//
//  AllFriendsViewController.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 10.07.2021.
//

import UIKit

class MyFriends: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    private var friends: [FriendModel] = []
    private var tapedInAvatar: Bool = false
    private var indexPathForPrepare: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FriendsGet().getFriends()
        PhotoesGetAll().getPhotoesAll()
        GroupsGet().getMyGroups()
        GroupsSearch().getMyGroups()
        
        friends = FriendStorage().friend
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
        // заполняем данные выбранной ячейки
        let friend = friends[indexPathForPrepare!.row]
        // передаем фото
        destinationController.photoes = friend.photo
        // передаем название
        destinationController.title = friend.name
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
extension MyFriends: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: FriendsTableViewCell.reusedIdentifire, for: indexPath) as? FriendsTableViewCell
        else {
            return UITableViewCell()
        }
        friends = friends.sorted(by: { $0.name < $1.name})
        let friend = friends[indexPath.row]
        cell.configure(friend: friend, indexPathFromTable: indexPath)
        cell.avatarTapped = { [weak self] in
            self?.tapedInAvatar = true
            self?.performSegue(withIdentifier: "moveToPhoto", sender: indexPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            friends.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .bottom)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// 2-3 часика на переход по аватаке
