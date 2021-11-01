//
//  NewsViewController.swift
//  VK_application
//
//  Шикарно с третьего раза Created by Сергей Чумовских  on 23.07.2021.
//  Пробую 4-й, и уже с сетью 26.10.2021

import UIKit

final class NewsVC: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    private var feed: NewsFeedResponse?
    private let countNews = 50
    
    let newsFeedServices = NewsFeedServices()
    let dateFormatterRU = DateFormatterRU()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getNewsFeed {
            self.setTableView()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == "showBigImageNews",
            let destinationController = segue.destination as? BigImageNewsVC,
            let indexPath = sender as? IndexPath,
            let attachments = feed?.items[indexPath.section].attachments
        else { return }
        destinationController.attachments = attachments
    }
    
    private func getNewsFeed(completion: @escaping () -> Void) {
        newsFeedServices.getNewsFeedPost(count: countNews) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let feed):
                DispatchQueue.main.async {
                    self.feed = feed
                    completion()
                }
            case .failure:
                print("getNewsFeed FAIL")
            }
        }
    }
}

//MARK: - Extension UITableView

extension NewsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return feed?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
            
            // первая ячейка (хедер)
        case 0:
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: NewsCellHeader.reusedIdentifier,
                                                         for: indexPath) as? NewsCellHeader,
                let feedPost = feed?.items[indexPath.section],
                let feedGroup = feed?.groups,
                let feedProfiles = feed?.profiles
            else {
                return UITableViewCell()
            }
            let id = feedPost.source_id
            let date = dateFormatterRU.ShowMeDate(date: feedPost.date)
            if id > 0 {
                var profile: NewsFeedProfile
                for i in 0..<feedProfiles.count {
                    if feedProfiles[i].id == id {
                        profile = feedProfiles[i]
                        let lastName = profile.last_name ?? " "
                        cell.configure(avatar: profile.photo_50,
                                       name: lastName + " " + profile.first_name,
                                       date: date)
                        break
                    }
                }
            } else {
                var group: NewsFeedGroup
                for i in 0..<feedGroup.count {
                    if feedGroup[i].id == -(id) {
                        group = feedGroup[i]
                        
                        cell.configure(avatar: group.photo_50,
                                       name: group.name,
                                       date: date)
                        break
                    }
                }
            }
            return cell
            
            // вторая ячейка (текст)
        case 1:
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: NewsCellText.reusedIdentifier,
                                                         for: indexPath) as? NewsCellText,
                let feedPost = feed?.items[indexPath.section]
            else {
                return UITableViewCell()
            }
            cell.configure(text: feedPost.text)
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
                let attachments = feed?.items[indexPath.section].attachments
            else {
                print("Return Media ERROR")
                return UITableViewCell()
            }
            cell.configure(attachments: attachments[0])
            cell.controlTapped = { [weak self] in
                self?.performSegue(withIdentifier: "showBigImageNews", sender: indexPath)}
            return cell
            
            // четвертая яейка (футер)
        default:
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: NewsCellFooter.reusedIdentifier,
                                                         for: indexPath) as? NewsCellFooter,
                let feedPost = feed?.items[indexPath.section],
                let comments = feedPost.comments,
                let likes = feedPost.likes,
                let reposts = feedPost.reposts,
                let views = feedPost.views
            else {
                print("Return Footer ERROR")
                return UITableViewCell()
            }
            cell.configure(comments: comments, likes: likes, reposts: reposts, views: views)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 80
        case 1:
            return tableView.rowHeight
        case 2:
            guard
                let attachments = feed?.items[indexPath.section].attachments,
                let sizeLast = attachments[0].photo?.sizes.endIndex,
                let heightPhoto = attachments[0].photo?.sizes[sizeLast-1].height
            else {
                return tableView.rowHeight
            }
            let heightPhotoCell = CGFloat(heightPhoto/2)
            return heightPhotoCell
        case 3:
            return 45
        default:
            return tableView.rowHeight
        }
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
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
