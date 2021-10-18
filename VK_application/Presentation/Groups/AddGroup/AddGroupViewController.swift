//
//  AddGroupViewController.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 13.07.2021.
//

import UIKit

final class AddGroupViewController: UIViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    // для клавиатуры
    private var tapGesture: UITapGestureRecognizer?
    // данные о группах
    private var afSearchGroups = GroupsServices()
    private var countSearch: Int = 200
    var groupsSearchAloma: [GroupsSearchItems] = []
    
    override func viewDidLoad() {
        super .viewDidLoad()
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    private func getGroupsSearchAloma(q: String, count: Int) {
        // q - параметр поиска
        afSearchGroups.getMyGroups(q: q, count: count) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let groups):
                self.groupsSearchAloma = groups
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure:
                print("getGroupsSearchAloma FAIL")
            }
        }
    }
    
    func joinSelectedGroup(selectedGroupID: Int) {
        afSearchGroups.getJoinGroup(groupID: selectedGroupID) {[weak self] result in
            guard self != nil else {
                print("fail self")
                return }
            switch result {
            case .success(let answer):
                print("Join to groupID = \(selectedGroupID) = \(answer)")
                self?.navigationController?.popViewController(animated: true)
            case .failure:
                print("Join to gropID = \(selectedGroupID) = FAIL")
            }
        }
    }
}

//MARK: - TableView

extension AddGroupViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groupsSearchAloma.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: AddGroupCell.reusedIdentifire, for: indexPath) as? AddGroupCell
        else {
            return UITableViewCell()
        }
        let group = groupsSearchAloma[indexPath.row]
        cell.configure(group: group)
        cell.avatarTapped = { [weak self] in
            self?.joinSelectedGroup(selectedGroupID: group.id)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        joinSelectedGroup(selectedGroupID: groupsSearchAloma[indexPath.row].id)
    }
}

//MARK: - SearchBar

extension AddGroupViewController: UISearchBarDelegate {
    // функция активируется при изменении текста в searchBar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            groupsSearchAloma = []
            tableView.reloadData()
        } else {
            getGroupsSearchAloma(q: searchText, count: countSearch)
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
