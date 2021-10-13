//
//  UserGroupsViewController.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 13.07.2021.
//

import SwiftUI
import Foundation
import RealmSwift

class UserGroupsViewController: UIViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    // для перехода по сеге
    var tapedInAvatar = false
    // для клавиатуры
    private var tapGesture: UITapGestureRecognizer?
    // данные групп
    private var afGroups = GroupsGet()
    var groupsAloma: [GroupsItems] = []
    var filteredGroups: [GroupsItems] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getGroupsAloma()
    }
    
    //MARK: - БД
    
    // Делаем запрос в сеть для обновления БД
    private func getGroupsAloma() {
        afGroups.getMyGroups(userId: UserSession.shared.userId) {[weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.loadData()
                self.tableView.reloadData()
            }
        }
    }
    
    // Загрузка данных из Realm
    private func loadData() {
        do {
            let realm = try Realm()
            // Чтение из БД по параметру myOwnerId
            let groups = realm.objects(GroupsItems.self).filter("ownerId == %@", UserSession.shared.userId)
            self.groupsAloma = Array(groups)
            self.filteredGroups = self.groupsAloma
            self.tableView.reloadData()
        } catch { print(error) }
    }
    
    //MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ProfileGroup2VC" else {return}
        if let vc = segue.destination as? ProfileGroup2VC {
            guard let send = sender as? Int else {
                print("FAIL cast")
                return}
            searchBar.text = nil
            vc.groupID = send
        }
    }
}

//MARK: - Extension UserGroups: UISearchBarDelegate

extension UserGroupsViewController: UISearchBarDelegate {
    
    // функция активируется при изменении текста в searchBar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredGroups = []
        if searchText.isEmpty {
            filteredGroups = groupsAloma
        } else {
            // проходим по массиву groups в поиске введенных символов без учета регистра
            for group in groupsAloma {
                if group.name.lowercased().contains(searchText.lowercased()) {
                    filteredGroups.append(group)
                }
            }
        }
        tableView.reloadData()
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

//MARK: - Extension UserGroups: UITabBarDelegate, UITableViewDataSource

extension UserGroupsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: UserGroupTableViewCell.reusedIdentifire, for: indexPath) as? UserGroupTableViewCell
        else {
            return UITableViewCell()
        }
        // Записываем в group значение из массива filteredGroups (SearchBar) для определенной строки
        let group = filteredGroups[indexPath.row]
        // Передаем значение строки в ячейку
        cell.configure(group: group)
        cell.avatarTapped = { [weak self] in
            self?.tapedInAvatar = true
            self?.performSegue(withIdentifier: "ProfileGroup2VC", sender: group.id)
        }
        return cell
    }
    
    // Удаление ячейки
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete,
              !indexPath.isEmpty
        else { return }
        let leaveGroup = GroupsSearch()
        let groupID = filteredGroups[indexPath.row].id
        leaveGroup.getLeaveGroup(groupID: groupID) {[weak self] result in
            guard self != nil else {
                print("fail self")
                return }
            switch result {
            case .success(let answer):
                self?.filteredGroups.remove(at: indexPath.row)
                self?.tableView.deleteRows(at: [indexPath], with: .none)
                print("Leave to groupID = \(groupID) = \(answer)")
            case .failure:
                print("Leave to gropID = \(groupID) = FAIL")
            }
        }
        DispatchQueue.main.async {
            tableView.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "ProfileGroup2VC", sender: filteredGroups[indexPath.row].id)
    }
    
}


