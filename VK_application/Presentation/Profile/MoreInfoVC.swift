//
//  MoreInfoVC.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 31.10.2021.
//

import UIKit
import SwiftUI

struct OtherInfoModel {
    let title: String
    let text: String?
}

struct MainInfoModel {
    let title: String
    let text: String?
}

struct ContactsInfoModel {
    let title: String
    let text: String?
}

struct PersonalInfoModel {
    let title: String
    let text: String?
}

class MoreInfoVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var otherModel: [OtherInfoModel] = []
    private var mainModel: [MainInfoModel] = []
    private var contactsModel: [ContactsInfoModel] = []
    private var personalModel: [PersonalInfoModel] = []
    
    var infoModel: UsersGetItems?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createArray()
        setUpTableView()
    }
    
    private func createArray() {
        guard let model = infoModel else {return}
        // общая
        otherModel.append(.init(title: "Цитаты", text: model.quotes))
        otherModel.append(.init(title: "День рождения", text: model.bdate))
        otherModel.append(.init(title: "Отношения", text: relationReturn(number: model.relation)))
        if let followers = model.followers_count {
        otherModel.append(.init(title: "Подписчики", text: "\(followers)"))
        }
        otherModel.append(.init(title: "О себе", text: model.about))
        // основная
        mainModel.append(.init(title: "Родной город", text: model.city?.title))
        // контакты
        contactsModel.append(.init(title: "Короткий адресс страницы", text: model.domain))
        contactsModel.append(.init(title: "Имя страницы", text: model.screen_name))
        contactsModel.append(.init(title: "Instagramm", text: model.instagram))
        // личная
        personalModel.append(.init(title: "Интересы", text: model.interests))
        personalModel.append(.init(title: "Деятельность", text: model.activities))
        personalModel.append(.init(title: "Любимые фильмы", text: model.movies))
        personalModel.append(.init(title: "Любимая музыка", text: model.music))
        personalModel.append(.init(title: "Любимые ТВ", text: model.tv))
        personalModel.append(.init(title: "Любимые игры", text: model.games))
        personalModel.append(.init(title: "Любимые книги", text: model.books))
    }
}

extension MoreInfoVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return otherModel.count
        case 1:
            return mainModel.count
        case 2:
            return contactsModel.count
        case 3:
            return personalModel.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Общая информация"
        case 1:
            return "Основная информация"
        case 2:
            return "Контакты"
        case 3:
            return "Личная информация"
        default:
            break
        }
        return "\(section)"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: MoreInfoViewCell.reusedIdentifier, for: indexPath) as? MoreInfoViewCell
        else {
            return UITableViewCell()
        }
        switch indexPath.section {
        case 0:
            cell.configure(nameAtribut: otherModel[indexPath.row].title, textAtribut: otherModel[indexPath.row].text ?? "")
        case 1:
            cell.configure(nameAtribut: mainModel[indexPath.row].title, textAtribut: mainModel[indexPath.row].text ?? "")
        case 2:
            cell.configure(nameAtribut: contactsModel[indexPath.row].title, textAtribut: contactsModel[indexPath.row].text ?? "")
        case 3:
            cell.configure(nameAtribut: personalModel[indexPath.row].title, textAtribut: personalModel[indexPath.row].text ?? "")
        default:
            cell.configure(nameAtribut: "", textAtribut: "")
        }
        return cell
    }
    
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderHeight = 40
        self.tableView.register(UINib(nibName: MoreInfoViewCell.reusedIdentifier, bundle: nil), forCellReuseIdentifier: MoreInfoViewCell.reusedIdentifier)
    }
    
}

// MARK: - Вычисление значений

extension MoreInfoVC {
    
    private func relationReturn(number: Int?) -> String {
        switch number {
        case 0:
            return "Не указано"
        case 1:
            return "Не женат/не замужем"
        case 2:
            return "Есть друг/есть подруга"
        case 3:
            return "Помолвлен/помолвлена"
        case 4:
            return "Женат/замужем"
        case 5:
            return "Всё сложно"
        case 6:
            return "В активном поиске"
        case 7:
            return "Влюблён/влюблена"
        case 8:
            return "В гражданском браке"
        default:
            return ""
        }
    }
}
