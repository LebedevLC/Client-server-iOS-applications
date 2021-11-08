//
//  UserGroupsViewController.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 13.07.2021.
//

import Foundation
import RealmSwift
import Alamofire

class UserGroupsViewController: UIViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    private var tapGesture: UITapGestureRecognizer?
    private var groupService = GroupsServices()
    private var groupsAloma: [GroupsItems] = []
    private var filteredGroups: [GroupsItems] = []
    
    private let operationQueue: OperationQueue = {
        let operationQueue = OperationQueue()
        operationQueue.name = "com.AsyncOperation.UserGroupsViewController"
        operationQueue.qualityOfService = .utility
        return operationQueue
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.separatorStyle = .none
        operationsSetup()
    }
    
    private func operationsSetup() {
        let myReguest = groupService.getMyGroupsReguest()
        let getData = GetDataOperation(request: myReguest)
        let parseData = DataParseOperation()
        let writeRealm = WriteRealmOperation()
        writeRealm.completionBlock = { [weak self] in
            self?.loadData()
        }
        parseData.addDependency(getData)
        writeRealm.addDependency(parseData)
        operationQueue.addOperation(getData)
        operationQueue.addOperation(parseData)
        operationQueue.addOperation(writeRealm)
    }
    
// MARK: - DataBase
    
    func loadData() {
        DispatchQueue.main.async {
            do {
                let realm = try Realm()
                let groups = realm.objects(GroupsItems.self).filter("ownerId == %@", UserSession.shared.userId)
                self.groupsAloma = Array(groups)
                self.filteredGroups = self.groupsAloma
                self.tableView.reloadData()
            } catch { print(error) }
        }
    }
}

// MARK: - Segue

extension UserGroupsViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ProfileGroup2VC" else {return}
        if let vc = segue.destination as? ProfileGroupVC {
            guard let send = sender as? Int else {
                print("FAIL cast")
                return}
            searchBar.text = nil
            vc.groupID = send
        }
    }
}

// MARK: - UISearchBarDelegate

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

// MARK: - TableView

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
        let group = filteredGroups[indexPath.row]
        cell.configure(group: group)
        cell.avatarTapped = { [weak self] in
            self?.performSegue(withIdentifier: "ProfileGroup2VC", sender: group.id)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete,
              !indexPath.isEmpty
        else { return }
        let groupID = filteredGroups[indexPath.row].id
        showDeleteAlert(id: groupID)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "ProfileGroup2VC", sender: filteredGroups[indexPath.row].id)
    }
}

// MARK: - Delete Alert

extension UserGroupsViewController {
    
    private func showDeleteAlert(id: Int) {
        let alertController = UIAlertController(title: "Удалить группу?", message: "Это действие действительно внесет изменения в ваш список групп", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Удалить", style: .destructive) { _ in
            self.groupService.getLeaveGroup(groupID: id) {[weak self] result in
                guard self != nil else {
                    print("fail self")
                    return }
                switch result {
                case .success(let answer):
                    print("Leave to groupID = \(id) = \(answer)")
                case .failure:
                    print("Leave to gropID = \(id) = FAIL")
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        alertController.addAction(confirmAction)
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: {})
    }
}
