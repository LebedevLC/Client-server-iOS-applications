//
//  ProfileVC.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 14.10.2021.
//
/*
 16.10.21 00:03
 Wall у меня готова, теперь, зная как обрабатывать изменения при парсинге,
 я могу доделать модель wall и сделать отображение постов моего профиля!!!
 */
import UIKit
import RealmSwift

class ProfileVC: UIViewController {

    @IBOutlet var barButtonItem: UIBarButtonItem!
    @IBOutlet var tableView: UITableView!
    
    private var photoesService = PhotoesServices()
    private var accountService = AccountServices()
    
    private var profileInfo: [AccountItems] = []
    private var photoesRealm: [PhotoesItems] = []
    
    private var isAvatarPhoto = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getProfileInfo()
        configureButtonMenu()
    }
    
    private func setTableView() {
        self.tableView.separatorStyle = .none
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: HeaderProfileCell.reusedIdentifier, bundle: nil),
                               forCellReuseIdentifier: HeaderProfileCell.reusedIdentifier)
    }
    
    
    //MARK: - Network
    
    // Получение списка друзей (веб-запрос, запись в БД)
    private func getProfileInfo() {
        accountService.getProfileInfo {[weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.loadProfileInfo()
                self.getProfileImage()
            }
        }
    }
    
    // Получение изображения профиля (веб-запрос, запись в БД)
    private func getProfileImage() {
        photoesService.getAlbumPhotoes(ownerID: UserSession.shared.userId) {[weak self] in
            guard let self = self else { return }
            self.loadProfileImage(userID: UserSession.shared.userId)
            self.setTableView()
            self.tableView.reloadData()
        }
    }
    
    //MARK: - DataBase
    
    // Realm - Profile info
    private func loadProfileInfo() {
        do {
            let realm = try Realm()
            // Чтение из БД по параметру Id
            let profileInfo = realm.objects(AccountItems.self).filter("id == %@", UserSession.shared.userId)
            self.profileInfo = Array(profileInfo)
        } catch { print(error) }
    }
    
    // Realm - Avatar
    private func loadProfileImage(userID: Int) {
        do {
            let realm = try Realm()
            // Чтение из БД по параметру "id" и фильтру "userID"
            let photoes = realm.objects(PhotoesItems.self).filter("id == %@", userID)
            guard photoes.count != 0 else {
                print("Account profile photoes = 0")
                isAvatarPhoto = false
                return
            }
            self.photoesRealm = Array(photoes)
        } catch { print(error) }
    }
    
}

//MARK: - TableView

extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: HeaderProfileCell.reusedIdentifier,
                for: indexPath) as? HeaderProfileCell
        else {
            return UITableViewCell()
        }
        let info = profileInfo[0]
        let photo = photoesRealm[0]
        cell.configure(accountItems: info, photoModel: photo)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
//            UIAction(title: "Алфавиту", image: UIImage(systemName: "character"), handler: { (_) in
//            }),
//            UIAction(title: "Городам", image: UIImage(systemName: "flag"), handler: { (_) in
//            }),
            UIAction(title: "Выйти", image: UIImage(systemName: "xmark.circle"), attributes: .destructive, handler: { (_) in
            })
        ]
    }
}

