//
//  AllFriendsViewController.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 10.07.2021.
//

import UIKit

class MyFriendsVC: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    private var friends: [FriendModel] = [] // доделать (убрать)
    private var tapedInAvatar: Bool = false
    private var indexPathForPrepare: IndexPath?
    
    
    private var afFriends = FriendsGet()
    var friedsAloma: [FriendsItems] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friends = FriendStorage().friend
        
        afFriends.getFriends() {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let friends):
                self.friedsAloma = friends
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure:
                print("getFriends FAIL")
            }
        }
        tableView.separatorStyle = .none
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            // проверяем какая сега хочет запуститься
            segue.identifier == "moveToPhoto",
            // кастим целевой контроллер
            let destinationController = segue.destination as? PhotoFriendViewController
        else { return }
        // костыли-велосипеды
        switch tapedInAvatar {
        case true:
            // если тап на аватарку, то читаем IndexPath её замыкания
            self.indexPathForPrepare = sender as? IndexPath
        case false:
            // иначе читаем с выбранной ячейки
            self.indexPathForPrepare = tableView.indexPathForSelectedRow
        }
        // заполняем данные для выбранной ячейки
        let friend = friedsAloma[indexPathForPrepare!.row]
        // передаем индекс выбранного пользователя
        destinationController.userID = friend.id
        // передаем заголовок
        destinationController.title = friend.first_name + " " + friend.last_name
        // меняем значение идентификатора нажатия (костыля)
        self.tapedInAvatar = false
    }
    
    @IBAction func refreshButtonPressed(_ sender: UIBarButtonItem) {
        tableView.reloadData()
        
    }
    
    @IBAction func addFriend(_ segue: UIStoryboardSegue) {
        var friend: FriendModel
        guard
            segue.identifier == "addFriend",
            let sourceController = segue.source as? AddFriendsViewController
        else { return }
        // Реализация тапа на аватарку или строку
        switch sourceController.tapedInAvatar {
        case false:
            guard let indexPaths = sourceController.tableView.indexPathForSelectedRow else { return }
            friend = sourceController.friendsSection[indexPaths.section][indexPaths.row]
        case true:
            guard let indexPaths = sourceController.indexPathForAddFriend else { return }
            friend = sourceController.friendsSection[indexPaths.section][indexPaths.row]
            sourceController.tapedInAvatar.toggle()
        }
        if !friends.contains(where: {$0.name == friend.name}) {
            friends.append(friend)
            tableView.reloadData()
        }
    }
    
}

// MARK: - Extension MyFriends Delegate, DataSourse
extension MyFriendsVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friedsAloma.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: FriendsTableViewCell.reusedIdentifire, for: indexPath) as? FriendsTableViewCell
        else {
            return UITableViewCell()
        }
        friedsAloma = friedsAloma.sorted(by: { $0.first_name < $1.first_name})
        let friend = friedsAloma[indexPath.row]
        cell.configure(friend: friend, indexPathFromTable: indexPath)
        cell.avatarTapped = { [weak self] in
            self?.tapedInAvatar = true
            self?.performSegue(withIdentifier: "moveToPhoto", sender: indexPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            friedsAloma.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .bottom)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

