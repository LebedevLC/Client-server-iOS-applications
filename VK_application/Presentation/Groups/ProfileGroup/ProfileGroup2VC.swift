//
//  ProfileGroupVC(TableView).swift
//  VK_application
//
//  Created by Сергей Чумовских  on 13.08.2021.
//

import UIKit
import RealmSwift

class ProfileGroup2VC: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    let wallService = WallServices()
    
    private var group: [GroupsItems] = []
    private var wall: [WallItems] = []
    
    private var countPostsLoad = 2
    
    var groupID: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.loadGroupData()
            self.getWallGroup() {
                self.setTableView()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    private func setTableView() {
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        
        // group header cell
        tableView.register(UINib(nibName: GroupCellHeader.reusedIdentifier, bundle: nil),
                           forCellReuseIdentifier: GroupCellHeader.reusedIdentifier)
        tableView.register(UINib(nibName: GroupCellLogo.reusedIdentifier, bundle: nil),
                           forCellReuseIdentifier: GroupCellLogo.reusedIdentifier)
        tableView.register(UINib(nibName: DescriptionCell.reusedIdentifier, bundle: nil),
                           forCellReuseIdentifier: DescriptionCell.reusedIdentifier)
        // news cell
        tableView.register(UINib(nibName: NewsCellHeader2.reusedIdentifier, bundle: nil),
                               forCellReuseIdentifier: NewsCellHeader2.reusedIdentifier)
        tableView.register(UINib(nibName: NewsCellText.reusedIdentifier, bundle: nil),
                               forCellReuseIdentifier: NewsCellText.reusedIdentifier)
        tableView.register(UINib(nibName: NewsCellPhoto.reusedIdentifier, bundle: nil),
                               forCellReuseIdentifier: NewsCellPhoto.reusedIdentifier)
        tableView.register(UINib(nibName: NewsCellFooter.reusedIdentifier, bundle: nil),
                               forCellReuseIdentifier: NewsCellFooter.reusedIdentifier)
        tableView.reloadData()
    }
    
//MARK: - Network
    
    // Network Wall
    private func getWallGroup(completion: @escaping () -> Void) {
        wallService.getWall(ownerID: -groupID, count: countPostsLoad) {[weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let wall):
                
                DispatchQueue.main.async {
                    self?.wall = wall
                    completion()
                }
            case .failure:
                print("getWallAloma FAIL")
            }
        }
    }
    
//MARK: - Database
    
    // Загрузка данных из Realm
    private func loadGroupData() {
        do {
            let realm = try Realm()
            // Чтение из группы БД по параметру id
            let groupRealm = realm.objects(GroupsItems.self).filter("id == %@", groupID)
            self.group = Array(groupRealm)
        } catch { print(error) }
    }
    
//MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "moreGroupInfo":
            guard
                let destinationController = segue.destination as? MoreGroupInfo
            else { return }
            destinationController.moreGroup = group[0]
        case "showBigImageNewsGroup":
            guard
                let destinationController = segue.destination as? BigImageNewsVC,
                let indexPath = sender as? IndexPath
            else { return }
            destinationController.wallPost = wall[indexPath.section - 1]
        default:
            return
        }
    }
}

//MARK: - TableView

extension ProfileGroup2VC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section > 0 && indexPath.row == 2 {
            let sizeLast = wall[indexPath.section - 1].attachments[0].photo.sizes.endIndex-1
            let heightPhotoCell = CGFloat(wall[indexPath.section - 1].attachments[0].photo.sizes[sizeLast].height/2)
//            print("\(heightPhotoCell) == heightPhotoCell")
            return heightPhotoCell
        } else {
            return tableView.rowHeight
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        wall.count + 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        } else {
            return 4
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {

        //MARK: - Group section

        case 0:
            switch indexPath.row {

// первая ячейка (хедер)
            case 0:
                guard
                    let cell = tableView.dequeueReusableCell(withIdentifier: GroupCellHeader.reusedIdentifier,
                                                             for: indexPath) as? GroupCellHeader
                else {
                    return UITableViewCell()
                }
                let group = group[0]
                cell.configure(group: group)
                return cell

// вторая ячейка (logo)
            case 1:
                guard
                    let cell = tableView.dequeueReusableCell(withIdentifier: GroupCellLogo.reusedIdentifier,
                                                             for: indexPath) as? GroupCellLogo
                else {
                    return UITableViewCell()
                }
                let group = group[0]
                cell.configure(group: group)
                return cell

// третья ячейка (description)
            case 2:
                guard
                    let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionCell.reusedIdentifier,
                                                             for: indexPath) as? DescriptionCell
                else {
                    return UITableViewCell()
                }

                let group = group[0]
                cell.configure(group: group)

                cell.buttonTapped = { [weak self] in
                    self?.performSegue(withIdentifier: "moreGroupInfo", sender: nil)}
                return cell
// default
            default:
                return UITableViewCell()
            }
        
        //MARK: - News Section
        
        default:
            switch indexPath.row {

// первая ячейка (хедер)
            case 0:
                guard
                    let cell = tableView.dequeueReusableCell(withIdentifier: NewsCellHeader2.reusedIdentifier,
                                                             for: indexPath) as? NewsCellHeader2
                else {
                    return UITableViewCell()
                }
                let wallData = wall[indexPath.section - 1]
                let group = group[0]
                cell.configure(wall: wallData, group: group)
                return cell

// вторая ячейка (текст)
            case 1:
                guard
                    let cell = tableView.dequeueReusableCell(withIdentifier: NewsCellText.reusedIdentifier,
                                                             for: indexPath) as? NewsCellText
                else {
                    return UITableViewCell()
                }
                let wallData = wall[indexPath.section - 1]
                cell.configure(wall: wallData)
                // реализация разворачивания и сворачивания текста
                cell.controlTapped = { [weak self] in
                    // обновляем данные
                    self?.tableView.reloadData()
                }
                return cell

// третья ячейка (медиа)
            case 2:
                guard
                    let cell = tableView.dequeueReusableCell(withIdentifier: NewsCellPhoto.reusedIdentifier,
                                                             for: indexPath) as? NewsCellPhoto
                else {
                    return UITableViewCell()
                }
                let wallData = wall[indexPath.section - 1]
                let group = group[0]
                cell.configure(wall: wallData, group: group)
                // обработка замыкания в ячейке
                cell.controlTapped = { [weak self] in
                    self?.performSegue(withIdentifier: "showBigImageNewsGroup", sender: indexPath)}
                print("\(tableView.rowHeight) == cell.height")
                print("\(wallData.attachments[0].photo.sizes[wallData.attachments[0].photo.sizes.endIndex-1].height) == end index height")
                return cell

// четвертая яейка (футер)
            default:
                guard
                    let cell = tableView.dequeueReusableCell(withIdentifier: NewsCellFooter.reusedIdentifier,
                                                             for: indexPath) as? NewsCellFooter
                else {
                    return UITableViewCell()
                }
                let wallData = wall[indexPath.section - 1]
                let group = group[0]
                cell.configure(wall: wallData, group: group)
//                cell.likeTapped = { [weak self] in
//                    self?.news[indexPath.section - 1].newsDataModel[0].newsIsLike.toggle()
//                    self?.tableView.reloadSections(IndexSet(integer: indexPath.section), with: .automatic)
//                }
//                cell.repostTapped = { [weak self] in
//                    self?.news[indexPath.section - 1].newsDataModel[0].newsIsRepost.toggle()
//                    self?.tableView.reloadSections(IndexSet(integer: indexPath.section), with: .automatic)
//                }
//                cell.commentTapped = { [weak self] in
//                    self?.news[indexPath.section - 1].newsDataModel[0].newsIsComment.toggle()
//                    self?.tableView.reloadSections(IndexSet(integer: indexPath.section), with: .automatic)
//                }
                return cell
            }
        }
    }
}
