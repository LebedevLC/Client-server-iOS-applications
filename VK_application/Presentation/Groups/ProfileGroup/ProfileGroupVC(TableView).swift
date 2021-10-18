//
//  ProfileGroupVC(TableView).swift
//  VK_application
//
//  Created by Сергей Чумовских  on 13.08.2021.
//

import UIKit

class ProfileGroup2VC: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var groupData: GroupModel?
    private var news: [NewsModel] = []
    
    var groupID: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        print("GroupID ProfileVC \(groupID)")
        
//        tableView.delegate = self
//        tableView.dataSource = self
        
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
        
        // test parameters
        let storage = NewsStorage()
        news = storage.news
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "moreGroupInfo":
            guard
                let destinationController = segue.destination as? MoreGroupInfo
            else { return }
            destinationController.group = groupData
        case "showBigImageNewsGroup":
            guard
                let destinationController = segue.destination as? BigImageNewsVC,
                let indexPath = sender as? IndexPath
            else { return }
            destinationController.imageName = news[indexPath.section - 1].newsImageName
            print(news[indexPath.section - 1].newsImageName)
        default:
            return
        }
    }
    
}

//extension ProfileGroup2VC: UITableViewDelegate, UITableViewDataSource {
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        news.count + 1
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == 0 {
//            return 3
//        } else {
//            return 4
//        }
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        switch indexPath.section {
//
////MARK: - Group section
//
//        case 0:
//            switch indexPath.row {
//
//// первая ячейка (хедер)
//            case 0:
//                guard
//                    let cell = tableView.dequeueReusableCell(withIdentifier: GroupCellHeader.reusedIdentifier,
//                                                             for: indexPath) as? GroupCellHeader
//                else {
//                    return UITableViewCell()
//                }
//                let groupLogoImage = groupData!.logoImage
//                cell.configure(image: groupLogoImage)
//                return cell
//
//// вторая ячейка (logo)
//            case 1:
//                guard
//                    let cell = tableView.dequeueReusableCell(withIdentifier: GroupCellLogo.reusedIdentifier,
//                                                             for: indexPath) as? GroupCellLogo
//                else {
//                    return UITableViewCell()
//                }
//                cell.configure(group: groupData!)
//                return cell
//
//// третья ячейка (description)
//            case 2:
//                guard
//                    let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionCell.reusedIdentifier,
//                                                             for: indexPath) as? DescriptionCell
//                else {
//                    return UITableViewCell()
//                }
//
//                cell.configure(group: groupData!)
//
//                cell.buttonTapped = { [weak self] in
//                    self?.performSegue(withIdentifier: "moreGroupInfo", sender: nil)}
//                return cell
//// default
//            default:
//                return UITableViewCell()
//            }
//
////MARK:- News Section
//        default:
//            switch indexPath.row {
//
//    // первая ячейка (хедер)
//            case 0:
//                guard
//                    let cell = tableView.dequeueReusableCell(withIdentifier: NewsCellHeader2.reusedIdentifier,
//                                                             for: indexPath) as? NewsCellHeader2
//                else {
//                    return UITableViewCell()
//                }
//                let newsData = news[indexPath.section - 1]
//                let friend = newsData.user[0]
//                cell.configure(friend: friend, newsData: newsData)
//                return cell
//
//    // вторая ячейка (текст)
//            case 1:
//                guard
//                    let cell = tableView.dequeueReusableCell(withIdentifier: NewsCellText.reusedIdentifier,
//                                                             for: indexPath) as? NewsCellText
//                else {
//                    return UITableViewCell()
//                }
//                let news = news[indexPath.section - 1]
//                cell.configure(news: news)
//                // реализация разворачивания и сворачивания текста
//                cell.controlTapped = { [weak self] in
//                    // обновляем данные
//                    self?.tableView.reloadData()
//                }
//                return cell
//
//    // третья ячейка (медиа)
//            case 2:
//                guard
//                    let cell = tableView.dequeueReusableCell(withIdentifier: NewsCellPhoto.reusedIdentifier,
//                                                             for: indexPath) as? NewsCellPhoto
//                else {
//                    return UITableViewCell()
//                }
//                let news = news[indexPath.section - 1]
//                cell.configure(news: news)
//                // обработка замыкания в ячейке
//                cell.controlTapped = { [weak self] in
//                    self?.performSegue(withIdentifier: "showBigImageNewsGroup", sender: indexPath)}
//                return cell
//
//    // четвертая яейка (футер)
//            default:
//                guard
//                    let cell = tableView.dequeueReusableCell(withIdentifier: NewsCellFooter.reusedIdentifier,
//                                                             for: indexPath) as? NewsCellFooter
//                else {
//                    return UITableViewCell()
//                }
//                cell.configure(newsData: news[indexPath.section - 1].newsDataModel[0])
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
//                return cell
//            }
//        }
//    }
//}
