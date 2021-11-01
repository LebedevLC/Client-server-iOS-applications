//
//  ProfileGroupVC.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 13.08.2021.
//

import UIKit
import RealmSwift

final class ProfileGroupVC: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    let wallService = WallServices()
    let dateFormatterRU = DateFormatterRU()
    
    private var group: [GroupsItems] = []
    private var wall: [WallItems] = []
    
    private let countPostsLoad = 100
    
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
    
//MARK: - Network
    
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
    
    private func loadGroupData() {
        do {
            let realm = try Realm()
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
                let indexPath = sender as? IndexPath,
                let attachments = wall[indexPath.section - 1].attachments
            else { return }
            destinationController.attachments = attachments
        default:
            return
        }
    }
}

//MARK: - TableView

extension ProfileGroupVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        wall.count + 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? 3 : 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
                
        //MARK: - Group section
                
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
                    let cell = tableView.dequeueReusableCell(withIdentifier: NewsCellHeader.reusedIdentifier,
                                                             for: indexPath) as? NewsCellHeader
                else {
                    return UITableViewCell()
                }
                let group = group[0]
                let wallData = wall[indexPath.section - 1]
                let date = dateFormatterRU.ShowMeDate(date: wallData.date)
                cell.configure(avatar: group.photo_100,
                               name: group.name,
                               date: date)
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
                cell.configure(text: wallData.text)
                // реализация разворачивания и сворачивания текста
                cell.controlTapped = { [weak self] in
                    self?.tableView.reloadData()
                }
                return cell

// третья ячейка (медиа)
            case 2:
                guard
                    let cell = tableView.dequeueReusableCell(withIdentifier: NewsCellPhoto.reusedIdentifier,
                                                             for: indexPath) as? NewsCellPhoto,
                    let attachments = wall[indexPath.section - 1].attachments
                else {
                    print("Return Media ERROR")
                    return UITableViewCell()
                }
                
                cell.configure(attachments: attachments[0])
                cell.controlTapped = { [weak self] in
                    self?.performSegue(withIdentifier: "showBigImageNewsGroup", sender: indexPath)}
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
                guard
                    let comments = wallData.comments,
                    let likes = wallData.likes,
                    let reposts = wallData.reposts,
                    let views = wallData.views
                else {
                    return UITableViewCell()
                }
                cell.configure(comments: comments, likes: likes, reposts: reposts, views: views)
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard
            indexPath.section > 0 && indexPath.row == 2,
            let attachments = self.wall[indexPath.section - 1].attachments,
            let sizeLast = attachments[0].photo?.sizes.endIndex,
            let heightPhoto = attachments[0].photo?.sizes[sizeLast-1].height
        else {
            return tableView.rowHeight
        }
        let heightPhotoCell = CGFloat(heightPhoto/2)
        return heightPhotoCell
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
        tableView.register(UINib(nibName: NewsCellHeader.reusedIdentifier, bundle: nil),
                               forCellReuseIdentifier: NewsCellHeader.reusedIdentifier)
        tableView.register(UINib(nibName: NewsCellText.reusedIdentifier, bundle: nil),
                               forCellReuseIdentifier: NewsCellText.reusedIdentifier)
        tableView.register(UINib(nibName: NewsCellPhoto.reusedIdentifier, bundle: nil),
                               forCellReuseIdentifier: NewsCellPhoto.reusedIdentifier)
        tableView.register(UINib(nibName: NewsCellFooter.reusedIdentifier, bundle: nil),
                               forCellReuseIdentifier: NewsCellFooter.reusedIdentifier)
        tableView.reloadData()
    }
}
