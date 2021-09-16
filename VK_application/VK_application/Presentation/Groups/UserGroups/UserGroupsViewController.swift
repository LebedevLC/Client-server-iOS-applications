//
//  UserGroupsViewController.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 13.07.2021.
//

import UIKit

class UserGroupsViewController: UIViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var groupTableView: UITableView!
    
    // массивы данных о группах
    private var groups: [GroupModel] = []
    private var filteredGroups: [GroupModel] = []
    // для фильтрации
    private var isCanDelete: Bool = true
    // переменные для перехода
    private var tapedInAvatar: Bool = false
    private var indexPathForPrepare: IndexPath?
    // для клавиатуры
    private var tapGesture: UITapGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        let storage = GroupStorage()
        groups = storage.group
        // заполняем массив для поиска
        filteredGroups = groups
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            // проверяем какая сега хочет запуститься
            segue.identifier == "ProfileGroup2VC",
            // кастим целевой контроллер
            let destinationController = segue.destination as? ProfileGroup2VC
        else { return }
        // костыли-велосипеды
        switch tapedInAvatar {
        case true:
            // если тап на аватарку, то читаем IndexPath её замыкания
            self.indexPathForPrepare = sender as? IndexPath
        case false:
            // иначе читаем с выбранной ячейки
            self.indexPathForPrepare = groupTableView.indexPathForSelectedRow
        }
        // заполняем данные выбранной ячейки
        let group = filteredGroups[indexPathForPrepare!.row]
        // передаем данные ячейки
        destinationController.groupData = group
        // меняем значение идентификатора нажатия (костыля)
        self.tapedInAvatar = false
    }
    
    // Segue для добавления новой группы из контроллера
    // AddGroupViewController(sourceController) в таблицу
    @IBAction func addGroup(_ segue: UIStoryboardSegue) {
        var group: GroupModel
        guard
            segue.identifier == "addGroup",
            let sourceController = segue.source as? AddGroupViewController
        else { return }
        // Реализация тапа на аватарку или строку
        switch sourceController.tapedInAvatar {
        case false:
            guard let indexPaths = sourceController.tableView.indexPathForSelectedRow else { return }
            group = sourceController.groups[indexPaths.row]
        case true:
            guard let indexPaths = sourceController.indexPathForAddGroup else { return }
            group = sourceController.groups[indexPaths.row]
            sourceController.tapedInAvatar.toggle()
        }
        if !groups.contains(where: {$0.nameGroup == group.nameGroup}) {
            groups.append(group)
            // заполняем массив для отображения
            filteredGroups = groups
            groupTableView.reloadData()
        }
    }
    
}

//MARK: - Extension UserGroups: UISearchBarDelegate

extension UserGroupsViewController: UISearchBarDelegate {
    
    // функция активируется при изменении текста в searchBar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredGroups = []
        if searchText.isEmpty {
            filteredGroups = groups
            isCanDelete = true
        } else {
            isCanDelete = false
            // проходим по массиву groups в поиске введенных символов без учета регистра
            for group in groups {
                if group.nameGroup.lowercased().contains(searchText.lowercased()) {
                    filteredGroups.append(group)
                }
            }
        }
        groupTableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        // Добавляем обработчик жестов, когда пользователь вызвал клавиаруту у UISearchBar
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        groupTableView.addGestureRecognizer(tapGesture!)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        // Убираем обработчик нажатий, когда пользователь ткнул в другое место
        groupTableView.removeGestureRecognizer(tapGesture!)
        // Так-же обнуляем обработчик
        tapGesture = nil
    }
    
    @objc func hideKeyboard() {
        self.groupTableView?.endEditing(true)
    }
    
}

//MARK: - Extension UserGroups: UITabBarDelegate, UITableViewDataSource

extension UserGroupsViewController: UITableViewDelegate, UITableViewDataSource{
    
    // Колличество секций
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    // Колличество ячеек в секции
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredGroups.count
    }
    
    // Подготовить и создать ячейку
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            // Приведение переменной cell к классу UserGroupTableViewCell
            let cell = tableView.dequeueReusableCell(withIdentifier: UserGroupTableViewCell.reusedIdentifire, for: indexPath) as? UserGroupTableViewCell
        else {
            return UITableViewCell()
        }
        groups = groups.sorted(by: { $0.nameGroup < $1.nameGroup})
//        filteredGroups = groups
        filteredGroups = filteredGroups.sorted(by: { $0.nameGroup < $1.nameGroup})
        // Сортировка списка фильтрованных через SearchBar групп по алфавиту
        // Записываем в group значение из массива filteredGroups (SearchBar) для определенной строки
        let group = filteredGroups[indexPath.row]
        // Передаем значение строки в ячейку
        cell.configure(group: group)
        cell.avatarTapped = { [weak self] in
            self?.tapedInAvatar = true
            self?.performSegue(withIdentifier: "ProfileGroup2VC", sender: indexPath)
        }
        // Возвращаем ячейку в таблицу для демонстрации
        return cell
    }
    
    // Удаление ячейки
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard isCanDelete else { return }
            filteredGroups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .bottom)
            groups = filteredGroups
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        groupTableView.deselectRow(at: indexPath, animated: true)
    }
    
}


