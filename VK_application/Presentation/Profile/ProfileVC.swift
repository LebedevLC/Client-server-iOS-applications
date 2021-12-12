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
    let online: Bool
}

struct HeaderCellModel {
    let name: String
    let status: String
    let date: String
    let avatar: String
}

class ProfileVC: UIViewController {
    
    @IBOutlet private var barButtonItem: UIBarButtonItem!
    @IBOutlet private var tableView: UITableView!
    
    private let usersService = UsersServices()
    private let photoesService = PhotoesServices()
    private let friendsService = FriendsServices()
    private let profileSimpleFactory = ProfileSimpleFactory()
    
    private var userInfo: [UsersGetItems] = []
    private var collectionPhotoes: [PhotoesItems] = []
    private var friends: [FriendsItems] = []
    private var modelsCell: [CollectionTableCellModel] = []
    private var headerModelsCell: [HeaderCellModel] = []
    private var mutal: Int = 0
    
    // значение профиля, по-умолчанию - своя страница
    var userId: Int = UserSession.shared.userId
    var showUserId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showUserId != nil ? userId = showUserId! : nil
        getUserInfo()
        configureButtonMenu()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Network
    
    private func getUserInfo() {
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            self.friendsService.getFriendsNoRealm(userId: self.userId, order: .hints) {[weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let friends):
                    self.friends = friends
                    self.setupFriendsModels()
                case .failure:
                    debugPrint("getFriendsNoRealm FAIL")
                }
            }
            self.usersService.getUsersInfo(userId: self.userId) {[weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let info):
                    self.userInfo = info
                    if !self.userInfo.isEmpty {
                        self.mutal = self.userInfo[0].common_count ?? 0
                    }
                    self.setupHeaderModel()
                case .failure:
                    debugPrint("getUsersInfo FAIL")
                }
            }
            self.photoesService.getPhotoesAllNoRealm(ownerID: self.userId) {[weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let photoes):
                    self.collectionPhotoes = photoes
                    DispatchQueue.main.async {
                        self.setTableView()
                    }
                case .failure:
                    debugPrint("getPhotoesAllNoRealm FAIL")
                }
            }
        }
    }
    
    // Friends to modelsCell
    private func setupFriendsModels() {
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            self.modelsCell = self.profileSimpleFactory.constructFriendsModelsCell(from: self.friends)
        }
        self.tableView.reloadData()
    }
    
    // Info header
    private func setupHeaderModel() {
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            guard !self.userInfo.isEmpty else { return }
            self.headerModelsCell = self.profileSimpleFactory.constructHeadersModelsCell(from: self.userInfo)
        }
        tableView.reloadData()
    }
    
}

// MARK: - TableView

extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    
    private func setTableView() {
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
                    for: indexPath) as? HeaderProfileCell,
                !headerModelsCell.isEmpty
            else {
                return UITableViewCell()
            }
            cell.configure(model: headerModelsCell[0])
            cell.moreInfoTapped = { [weak self] in
                self?.performSegue(withIdentifier: "goToMoreInfo", sender: nil)
            }
            return cell
            
// Friends
        case 1:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: FriendsCollectionTableViewCell.identifier,
                for: indexPath) as? FriendsCollectionTableViewCell
            else {
                return UITableViewCell()
            }
            cell.configure(models: modelsCell, mutal: mutal)
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
            cell.allPhotoesTapped = { [weak self] in
                self?.performSegue(withIdentifier: "goToPhotoes", sender: nil)
            }
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

// MARK: - Bar Button Items

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

// MARK: - Segue

extension ProfileVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "goToPhotoes":
            guard let destinationVC = segue.destination as? PhotoesFriendVC
            else { return }
            destinationVC.userID = userId
        case "goToMoreInfo":
            guard let destinationVC = segue.destination as? MoreInfoVC
            else { return }
            destinationVC.infoModel = userInfo[0]
        default:
            debugPrint("unkown segue")
        }
    }
}
