//
//  AddFriendsViewController.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 10.07.2021.
//

import UIKit

final class AddFriendsViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var lettersControl: LettersControl!
    
    var friendsSection = [[FriendModel]]()
    
    var tapedInAvatar: Bool = false
    var indexPathForAddFriend: IndexPath?
    
    private var firstLetters: [String] = []
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        let friends = FriendStorage().allFriends
        firstLetters = getFirstLetters(friends)
        lettersControl.setLetters(firstLetters)
        lettersControl.addTarget(self, action: #selector(scrollToLetter), for: .valueChanged)
        
        friendsSection = sortedForSection(friends, firstLetters: firstLetters)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: AddFriendCell.reusedIdentifier, bundle: nil),
                           forCellReuseIdentifier: AddFriendCell.reusedIdentifier)
        
        tableView.register(AddFriendsViewHeader.self,
                           forHeaderFooterViewReuseIdentifier: AddFriendsViewHeader.reusedIdentifier)
    }
    
    /// Переместиться к указанному первому символу в таблице
    @objc func scrollToLetter() {
        let letter = lettersControl.selectLetter
        guard
            let firstIndexForLetter = friendsSection.firstIndex(where: { String($0.first?.name.prefix(1) ?? "" ) == letter })
        else {
            return
        }
        tableView.scrollToRow(
            at: IndexPath(row: 0, section: firstIndexForLetter),
            at: .top,
            animated: true)
    }
    
    /// Получить первые символы имен из модели
    private func getFirstLetters(_ friends: [FriendModel]) -> [String] {
        let friendsName = friends.map { $0.name }
        let firstLetters = Array(Set(friendsName.map { String($0.prefix(1)) })).sorted()
        return firstLetters
    }
    
    private func sortedForSection(_ friends: [FriendModel], firstLetters: [String]) -> [[FriendModel]] {
        var friendsSorted: [[FriendModel]] = []
        firstLetters.forEach { letter in
            let friendsForLetter = friends.filter { String($0.name.prefix(1)) == letter}
            friendsSorted.append(friendsForLetter)
        }
        return friendsSorted
    }
    
}

//MARK: - Extension AddFriendsViewController
extension AddFriendsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        friendsSection.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        friendsSection[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: AddFriendCell.reusedIdentifier, for: indexPath) as? AddFriendCell
        else {
            return UITableViewCell()
        }
        let friend = friendsSection[indexPath.section][indexPath.row]
        cell.configure(friend: friend)
        cell.avatarTapped = { [weak self] in
            self?.tapedInAvatar = true
            self?.indexPathForAddFriend = indexPath
            self?.performSegue(withIdentifier: "addFriend", sender: indexPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: AddFriendsViewHeader.reusedIdentifier) as? AddFriendsViewHeader
        else {
            return nil
        }
        header.configure(title: firstLetters[section])
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "addFriend", sender: nil)
    }
    
}
