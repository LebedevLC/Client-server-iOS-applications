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
    private var userService = UsersServices()
    private var friendService = FriendsServices()
    private var countSearch: Int = 200
    var usersFromAloma: [UsersSearchItems] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLetters()
        getSuggestionsFriends()
    }
    
    private func setupTable() {
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: AddFriendCell.reusedIdentifier, bundle: nil),
                           forCellReuseIdentifier: AddFriendCell.reusedIdentifier)
        
        tableView.register(AddFriendsViewHeader.self,
                           forHeaderFooterViewReuseIdentifier: AddFriendsViewHeader.reusedIdentifier)
        setupLetters()
    }
    
// MARK: - Network
    
    private func getSuggestionsFriends() {
        let queue = DispatchQueue.global(qos: .utility)
        queue.async{
            self.friendService.getSuggestionsFriends {[weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let users):
                    self.usersFromAloma = users
                    DispatchQueue.main.async {
                        self.setupTable()
                        self.tableView.reloadData()
                    }
                case .failure:
                    print("getSuggestionsFriends FAIL")
                }
            }
        }
    }
    
    private func searchUsers(q: String, count: Int) {
        userService.getSearchUsers(q: q, count: count) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let users):
                self.usersFromAloma = users
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
    
    private func goToProfile(userID: Int) {
        performSegue(withIdentifier: "fromSearchToProfileVC", sender: userID)
    }
    
// MARK: - Segue

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == "fromSearchToProfileVC",
            let destinationVC = segue.destination as? ProfileVC,
            let id = sender as? Int
        else { return }
        destinationVC.showUserId = id
    }
    
// MARK: - Sorting
    
    private func setupLetters(){
        firstLetters = getFirstLetters(usersFromAloma)
        lettersControl.setLetters(firstLetters)
        lettersControl.addTarget(self, action: #selector(scrollToLetter), for: .valueChanged)
        usersSection = sortedForSection(usersFromAloma, firstLetters: firstLetters)
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

// MARK: - TableView

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
            self?.goToProfile(userID: user.id)
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
        goToProfile(userID: usersSection[indexPath.section][indexPath.row].id)
    }
}

// MARK: - SearchBar

extension AddFriendsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            usersFromAloma = []
            tableView.reloadData()
        } else {
            searchUsers(q: searchText, count: countSearch)
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tableView.addGestureRecognizer(tapGesture!)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        tableView.removeGestureRecognizer(tapGesture!)
        tapGesture = nil
    }
    
    @objc func hideKeyboard() {
        self.tableView?.endEditing(true)
    }
}
