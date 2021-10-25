//
//  ProfileVC.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 14.10.2021.
//

import UIKit
import RealmSwift

struct CollectionTableCellModel {
    let title: String
    let imageName: String
}

class ProfileVC: UIViewController {
    
    @IBOutlet var barButtonItem: UIBarButtonItem!
    @IBOutlet var tableView: UITableView!
    
    private var photoesService = PhotoesServices()
    private var accountService = AccountServices()
    
    private var profileInfo: [AccountItems] = []
    private var avatarPhotoes: [PhotoesItems] = []
    private var collectionPhotoes: [PhotoesItems] = []
    private var friendsRealm: [FriendsItems] = []
    private var modelsCell: [CollectionTableCellModel] = []
    
    // значение профиля по-умолчанию - своя страница
    private var userID: Int = UserSession.shared.userId
    
    private var isAvatarPhoto = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getProfileInfo()
        configureButtonMenu()
    }
    
//MARK: - Network
    
    // Получение списка друзей (веб-запрос, запись в БД)
    private func getProfileInfo() {
        accountService.getProfileInfo {[weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.loadProfileInfo()
                self.getPhotoesUser(userId: self.userID)
            }
        }
    }
    
    // Получить фотографии пользователя
    private func getPhotoesUser(userId: Int) {
        photoesService.getPhotoesAll(ownerID: userId) {[weak self] in
            guard let self = self else { return }
            self.loadCollectionPhotoes(userID: userId)
            self.setTableView()
        }
    }
    
//MARK: - DataBase
    
    // Realm - Profile info
    private func loadProfileInfo() {
        do {
            let realm = try Realm()
            let profileInfo = realm.objects(AccountItems.self).filter("id == %@", userID)
            // Запись информации профиля в локальную переменную
            self.profileInfo = Array(profileInfo)
            let friends = realm.objects(FriendsItems.self).filter("myOwnerId == %@", userID)
            let sotrFriends = friends.sorted(byKeyPath: "online", ascending: false)
            self.friendsRealm = Array(sotrFriends)
        } catch { print(error) }
        for i in 0...(friendsRealm.count - 1) {
            let name = friendsRealm[i].first_name + " " + friendsRealm[i].last_name
            let url = friendsRealm[i].photo_100
            modelsCell.append(.init(title: name, imageName: url))
        }
    }
    
    // Realm - Photoes
    private func loadCollectionPhotoes(userID: Int) {
        do {
            let realm = try Realm()
            let photoes = realm.objects(PhotoesItems.self).filter("id == %@ AND album_id != %@", userID, -6)
            let avatar = realm.objects(PhotoesItems.self).filter("id == %@ AND album_id == %@", userID, -6)
            guard photoes.count != 0 else {
                print("friend count photoes = 0")
                return
            }
            self.collectionPhotoes = Array(photoes)
            self.avatarPhotoes = Array(avatar)
            self.tableView.reloadData()
        } catch { print(error) }
    }
}

//MARK: - TableView

extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    
    private func setTableView() {
//        self.tableView.separatorStyle = .none
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: HeaderProfileCell.reusedIdentifier, bundle: nil),
                                forCellReuseIdentifier: HeaderProfileCell.reusedIdentifier)
        self.tableView.register(FriendsCollectionTableViewCell.self,
                                forCellReuseIdentifier: FriendsCollectionTableViewCell.identifier)
        self.tableView.register(ProfilePhotoTableCell.self,
                                forCellReuseIdentifier: ProfilePhotoTableCell.identifier)
        self.tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
            
// Header
        case 0:
            guard
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: HeaderProfileCell.reusedIdentifier,
                    for: indexPath) as? HeaderProfileCell
            else {
                return UITableViewCell()
            }
            let info = profileInfo[0]
            let photo = avatarPhotoes[0]
            cell.configure(accountItems: info, photoModel: photo, friendCount: modelsCell.count)
            return cell
            
// Friends
        case 1:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: FriendsCollectionTableViewCell.identifier,
                for: indexPath) as? FriendsCollectionTableViewCell
            else {
                return UITableViewCell()
            }
            cell.configure(with: modelsCell)
            return cell
            
// Photo collection
        case 2 :
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ProfilePhotoTableCell.identifier,
                for: indexPath) as? ProfilePhotoTableCell
            else {
                return UITableViewCell()
            }
            cell.configure(with: collectionPhotoes)
            return cell
            
// Default
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 1:
            return 175
        case 2:
            return 335
        default:
            return tableView.rowHeight
        }
    }
}

//MARK: - Bar Button Items

extension ProfileVC {
    
    private func configureButtonMenu() {
        let item = barButtonItem
        item?.menu = configureMenu
    }
    
    private var configureMenu: UIMenu {
        return UIMenu(
            title: "Действия",
            image: UIImage(systemName: "gearshape"),
            identifier: nil,
            options: [],
            children: sortingMenuItems)
    }
    
    private var sortingMenuItems: [UIAction] {
        return [
            UIAction(title: "Выйти", image: UIImage(systemName: "xmark.circle"), attributes: .destructive, handler: { (_) in
            })
        ]
    }
}

