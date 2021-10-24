//
//  AddFriendsViewController.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 10.07.2021.
//

import UIKit
import RealmSwift

final class AddFriendsViewController: UIViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var lettersControl: LettersControl!
    
    // Для клавиатуры
    private var tapGesture: UITapGestureRecognizer?
    // Для боковой панели
    private var usersSection = [[UsersSearchItems]]()
    private var firstLetters: [String] = []
    // Пользователи
    private var afSearchUsers = UsersServices()
    private var friendService = FriendsServices()
    private var countSearch: Int = 200
    var usersSearchAloma: [UsersSearchItems] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: AddFriendCell.reusedIdentifier, bundle: nil),
                           forCellReuseIdentifier: AddFriendCell.reusedIdentifier)
        
        tableView.register(AddFriendsViewHeader.self,
                           forHeaderFooterViewReuseIdentifier: AddFriendsViewHeader.reusedIdentifier)
        setupLetters()
    }
    
    //MARK: - Aloma
    
    private func getUsersSearchAloma(q: String, count: Int) {
        // q - параметр поиска
        afSearchUsers.getSearchUsers(q: q, count: count) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let users):
                self.usersSearchAloma = users
                DispatchQueue.main.async {
                    self.lettersControl.refreshButtons()
                    self.setupLetters()
                    self.tableView.reloadData()
                }
            case .failure:
                print("getUsersSearchAloma FAIL")
            }
        }
    }
    
    private func addFriendAloma(userID: Int) {
        friendService.getAddFriend(userID: userID) {[weak self] result in
            guard self != nil else {
                print("FAIL self")
                return }
            switch result {
            case .success(let answer):
                print("Add friend to UserID = \(userID) = \(answer)")
                // Add friend
                self?.navigationController?.popViewController(animated: true)
            case .failure(let failCode):
                print("Add friend to UserID = \(userID) = FAIL = \(failCode)")
                // UIAlertAction
            }
        }
    }
    
    //MARK: - Sorting
    
    private func setupLetters(){
        firstLetters = getFirstLetters(usersSearchAloma)
        lettersControl.setLetters(firstLetters)
        lettersControl.addTarget(self, action: #selector(scrollToLetter), for: .valueChanged)
        usersSection = sortedForSection(usersSearchAloma, firstLetters: firstLetters)
    }
    
    /// Переместиться к указанному первому символу в таблице
    @objc func scrollToLetter() {
        let letter = lettersControl.selectLetter
        guard
            let firstIndexForLetter = usersSection.firstIndex(where: { String($0.first?.first_name.prefix(1) ?? "" ) == letter })
        else {
            return
        }
        tableView.scrollToRow(
            at: IndexPath(row: 0, section: firstIndexForLetter),
            at: .top,
            animated: true)
    }
    
    /// Получить первые символы имен из модели
    private func getFirstLetters(_ users: [UsersSearchItems]) -> [String] {
        let usersName = users.map { $0.first_name }
        let firstLetters = Array(Set(usersName.map { String($0.prefix(1)) })).sorted()
        return firstLetters
    }
    
    private func sortedForSection(_ users: [UsersSearchItems], firstLetters: [String]) -> [[UsersSearchItems]] {
        var friendsSorted: [[UsersSearchItems]] = []
        firstLetters.forEach { letter in
            let friendsForLetter = users.filter { String($0.first_name.prefix(1)) == letter}
            friendsSorted.append(friendsForLetter)
        }
        return friendsSorted
    }
}

//MARK: - Extension AddFriendsViewController

extension AddFriendsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        usersSection.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        usersSection[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: AddFriendCell.reusedIdentifier, for: indexPath) as? AddFriendCell
        else {
            return UITableViewCell()
        }
        let user = usersSection[indexPath.section][indexPath.row]
        cell.configure(user: user)
        cell.avatarTapped = { [weak self] in
            // AlomaSend - AddFriend
            self?.addFriendAloma(userID: user.id)
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
        tableView.deselectRow(at: indexPath, animated: true)
        // AlomaSend - AddFriend
        addFriendAloma(userID: usersSection[indexPath.section][indexPath.row].id)
    }
}

//MARK: - SearchBar

extension AddFriendsViewController: UISearchBarDelegate {
    // функция активируется при изменении текста в searchBar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            usersSearchAloma = []
            tableView.reloadData()
        } else {
            getUsersSearchAloma(q: searchText, count: countSearch)
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        // Добавляем обработчик жестов, когда пользователь вызвал клавиаруту у UISearchBar
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tableView.addGestureRecognizer(tapGesture!)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        // Убираем обработчик нажатий, когда пользователь ткнул в другое место
        tableView.removeGestureRecognizer(tapGesture!)
        // Так-же обнуляем обработчик
        tapGesture = nil
    }
    
    @objc func hideKeyboard() {
        self.tableView?.endEditing(true)
    }
}
