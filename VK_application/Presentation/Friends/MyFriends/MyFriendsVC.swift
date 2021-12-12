//
//  AllFriendsViewController.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 10.07.2021.
//

import UIKit
import Foundation
import RealmSwift

class MyFriendsVC: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var sortBarButtonItem: UIBarButtonItem!
    
    private var friendsServices = FriendsServices()
    // параметр для сортиовки при запросе
    private var order: FriendsServices.Order = .hints
    private var backUserId: Int?
    
    private var token: NotificationToken?
    private var friendsRealmNotification: Results<FriendsItems>?
    
    // MARK: - LifeCicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        pairTableAndRealm()
        configureButtonMenu()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFriendsAloma(order: self.order)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        returnToFriendRow(id: backUserId)
    }
    
    // MARK: - DataBase
    
    // Получение данных из БД, подписка на нотификацию и обновление таблицы
    private func pairTableAndRealm() {
        guard let realm = try? Realm() else { return }
        friendsRealmNotification = realm.objects(FriendsItems.self)
        guard let friendsRealmNotification = friendsRealmNotification else {return}
        token = friendsRealmNotification.observe { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else { return }
            switch changes {
            case .initial:
                tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                tableView.beginUpdates()
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                     with: .none)
                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                     with: .none)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                     with: .none)
                tableView.endUpdates()
            case .error(let error):
                print("observe.error")
                fatalError("\(error)")
            }
        }
    }
    
    // Получение списка друзей (веб-запрос, запись в БД)
    private func getFriendsAloma(order: FriendsServices.Order) {
        friendsServices.getFriends(userId: UserSession.shared.userId, order: order)
        self.loadData()
    }
    
    // Загрузка данных из Realm
    private func loadData() {
        do {
            let realm = try Realm()
            let friends = realm.objects(FriendsItems.self).filter("myOwnerId == %@", UserSession.shared.userId)
            // сервер сортирует по параметрам, а мы добавим тех кто "В сети" в начало
            let sotrFriends = friends.sorted(byKeyPath: "online", ascending: false)
            self.friendsRealmNotification = sotrFriends
        } catch { print(error) }
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == "goToProfile",
            let destinationVC = segue.destination as? ProfileVC,
            let indexPath = sender as? IndexPath,
            let id = friendsRealmNotification?[indexPath.row].id
        else { return }
        destinationVC.showUserId = id
    }
    
    // вернуться к ячейке выбранного пользователя
    private func returnToFriendRow(id: Int?) {
        guard
            let x = backUserId,
            let firstIndexForFriend = friendsRealmNotification?.firstIndex(where: { $0.id == x })
        else { return }
            tableView.scrollToRow(
                at: IndexPath(row: firstIndexForFriend, section: 0),
                at: .middle,
                animated: false)
    }
    
    // MARK: - Bar Button Items
    
    private func configureButtonMenu() {
        let item = sortBarButtonItem
        item?.menu = sortingMenu
    }
    
    private var sortingMenuItems: [UIAction] {
        return [
            UIAction(title: "Алфавиту", image: UIImage(systemName: "character"), handler: { (_) in
                self.order = .name
                self.getFriendsAloma(order: self.order)
            }),
            UIAction(title: "Городам", image: UIImage(systemName: "flag"), handler: { (_) in
                do {
                    let realm = try Realm()
                    let friendsTitle = realm.objects(FriendsItems.self)
                    let sortFriendsTitle = friendsTitle.sorted(byKeyPath: "title")
                    self.friendsRealmNotification = sortFriendsTitle
                    self.tableView.reloadData()
                } catch { print(error) }
            }),
            UIAction(title: "Рейтингу", image: UIImage(systemName: "star"), handler: { (_) in
                self.order = .hints
                self.getFriendsAloma(order: self.order)
            })
        ]
    }
    
    private var sortingMenu: UIMenu {
        return UIMenu(
            title: "Сортировать по",
            image: UIImage(systemName: "filemenu.and.cursorarrow"),
            identifier: nil,
            options: [],
            children: sortingMenuItems)
    }
    
    // Обновить данные из сети
    @IBAction func refreshButtonPressed(_ sender: UIBarButtonItem) {
        getFriendsAloma(order: self.order)
    }
}

// MARK: - TableView

extension MyFriendsVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let friendsRealmNotification = self.friendsRealmNotification else { return 0 }
        return friendsRealmNotification.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: FriendsTableViewCell.reusedIdentifire, for: indexPath) as? FriendsTableViewCell
        else {
            return UITableViewCell()
        }
        guard let friendsRealmNotification = self.friendsRealmNotification else { return UITableViewCell() }
        let friend = friendsRealmNotification[indexPath.row]
        cell.configure(friend: friend)
        cell.avatarTapped = { [weak self] in
            self?.performSegue(withIdentifier: "goToProfile", sender: indexPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let friendsRealmNotification = self.friendsRealmNotification else { return }
        if editingStyle == .delete {
            let friend = friendsRealmNotification[indexPath.row]
            showDeleteAlert(id: friend.id)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "goToProfile", sender: indexPath)
    }
}

// MARK: - Delete Alert

extension MyFriendsVC {
    
    private func showDeleteAlert(id: Int) {
        let alertController = UIAlertController(title: "Удалить друга?", message: "Это действие действительно внесет изменения в ваш список друзей", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Удалить", style: .destructive) { _ in
            self.friendsServices.getDeleteFriend(userID: id) { [weak self] result in
                guard self != nil else {
                    print("fail self")
                    return }
                switch result {
                case .success(let answer):
                    self?.getFriendsAloma(order: self!.order)
                    print("Delete to userID = \(id) = \(answer)")
                case .failure:
                    print("Delete to userID = \(id) = FAIL")
                }
            }
        }
        alertController.addAction(confirmAction)
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: {})
    }
}
