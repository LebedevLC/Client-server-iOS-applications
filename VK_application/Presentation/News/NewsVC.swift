//
//  NewsViewController.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 23.07.2021.

import UIKit

final class NewsVC: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    private var feed: NewsFeedResponse?
    private let countNews = 7
    
    private let newsFeedServices = NewsFeedServices()
    private let dateFormatterRU = DateFormatterRU()
    private var nextFrom = ""
    private var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefreshControl()
        getNewsFeed()
    }
    
    // MARK: - Network
    
    private func getNewsFeed() {
        let queue = DispatchQueue.global(qos: .utility)
        queue.async{
            self.newsFeedServices.getNewsFeedPost(count: self.countNews) {[weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let feed):
                    DispatchQueue.main.async {
                        self.feed = feed
                        self.setTableView()
                        guard let nextFrom = feed.next_from else {
                            debugPrint("no feed.next_from")
                            return }
                        self.nextFrom = nextFrom
                    }
                case .failure:
                    debugPrint("getNewsFeed FAIL")
                }
            }
        }
    }
}

// MARK: - Extension UITableView

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
            let id = feedPost.source_id ?? 0
            let date = dateFormatterRU.ShowMeDate(date: feedPost.date ?? 0)
            if id > 0 {
                var profile: NewsFeedProfile
                for i in 0..<feedProfiles.count where feedProfiles[i].id == id {
                    profile = feedProfiles[i]
                    let lastName = profile.last_name ?? " "
                    let firstName = profile.first_name ?? ""
                    cell.configure(
                        avatar: profile.photo_50 ?? "",
                        name: lastName + " " + firstName,
                        date: date
                    )
                    break
                }
            } else {
                var group: NewsFeedGroup
                for i in 0..<feedGroup.count where feedGroup[i].id == -(id) {
                    group = feedGroup[i]
                    cell.configure(
                        avatar: group.photo_50 ?? "",
                        name: group.name ?? "",
                        date: date
                    )
                    break
                }
            }
            return cell
            
        // вторая ячейка (текст)
        case 1:
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: NewsCellText.reusedIdentifier,
                                                         for: indexPath) as? NewsCellText
            else {
                return UITableViewCell()
            }
            let feedPost = feed?.items[indexPath.section].text ?? ""
            cell.configure(text: feedPost)
            cell.controlTapped = { [weak self] in
                self?.tableView.reloadSections(IndexSet(integer: indexPath.section), with: .none)
            }
            return cell
            
        // третья ячейка (медиа)
        case 2:
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: NewsCellPhoto.reusedIdentifier,
                                                         for: indexPath) as? NewsCellPhoto,
                let attachments = feed?.items[indexPath.section].attachments?.first
            else {
                debugPrint("No media in cell")
                return UITableViewCell()
            }
            cell.configure(attachments: attachments)
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
                debugPrint("Return Footer ERROR")
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
            if feed?.items[indexPath.section].text == "" {
                return 1
            } else {
                return tableView.rowHeight }
        case 2:
            guard
                let attachments = feed?.items[indexPath.section].attachments,
                let sizeLast = attachments[0].photo?.sizes?.endIndex,
                let heightPhoto = attachments[0].photo?.sizes?[sizeLast-1].height,
                let widthPhoto = attachments[0].photo?.sizes?[sizeLast-1].width
            else {
                return 1
            }
            let heightPhotoCell = CGFloat(heightPhoto/widthPhoto) * tableView.bounds.width
            return heightPhotoCell
        case 3:
            return 45
        default:
            return tableView.rowHeight
        }
    }
    
    private func setTableView() {
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        
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

// MARK: - Segue

extension NewsVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == "showBigImageNews",
            let destinationController = segue.destination as? BigImageNewsVC,
            let indexPath = sender as? IndexPath,
            let attachments = feed?.items[indexPath.section].attachments
        else { return }
        destinationController.attachments = attachments
    }
}

// MARK: - Pull to Refresh

extension NewsVC {

    private func setupRefreshControl() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.attributedTitle = NSAttributedString(string: "Обновление...")
        tableView.refreshControl?.tintColor = .link
        tableView.refreshControl?.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
    }
    
    @objc func refreshNews() {
        tableView.refreshControl?.beginRefreshing()
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            let mostFreshNewsDate = self.feed?.items.first?.date ?? Date().timeIntervalSince1970
            self.newsFeedServices.getNewsFeedPost(
                count: self.countNews,
                startTime: mostFreshNewsDate + 3) {[weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success(let feed):
                        guard feed.items.count > 0 else {
                            self.tableView.refreshControl?.endRefreshing()
                            debugPrint("no new newsFeed")
                            return }
                        let newGroups = feed.groups
                        let newProfiles = feed.profiles
                        let feedCount = self.feed?.items.count ?? 0
                        
                        self.feed?.groups?.append(contentsOf: newGroups!)
                        self.feed?.profiles?.append(contentsOf: newProfiles!)
                        self.feed?.items.insert(contentsOf: feed.items, at: 0)
                        
                        DispatchQueue.main.async {
                            self.tableView.refreshControl?.endRefreshing()
                            let indexSet = IndexSet(integersIn: feedCount..<(feedCount + feed.items.count))
                            self.tableView.insertSections(indexSet, with: .automatic)
                            self.tableView.reloadData()
                        }
                    case .failure:
                        debugPrint("getNewsFeed FAIL")
                    }
                }
        }
    }
}

// MARK: - Infinite Scrolling

extension NewsVC: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard
            let maxSection = indexPaths.map({ $0.section }).max(),
            let count = feed?.items.count
        else { return }
        if maxSection > count - 3,
           !isLoading {
            isLoading = true
            newsFeedServices.getNewsFeedPost(count: countNews, startFrom: nextFrom) {[weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let feed):
                    guard feed.items.count > 0 else {
                        debugPrint("no next newsFeed")
                        return }
                    guard let nextFrom = feed.next_from else {
                        debugPrint("no feed.next_from")
                        return }
                    let newGroups = feed.groups ?? []
                    let newProfiles = feed.profiles ?? []
                    let feedCount = self.feed?.items.count ?? 0
                    
                    self.feed?.groups?.append(contentsOf: newGroups)
                    self.feed?.profiles?.append(contentsOf: newProfiles)
                    self.feed?.items.append(contentsOf: feed.items)
                    self.nextFrom = nextFrom
                    
                    let indexSet = IndexSet(integersIn: feedCount..<(feedCount + feed.items.count))
                    self.tableView.insertSections(indexSet, with: .automatic)
                    
                case .failure:
                    debugPrint("getNewsFeed FAIL")
                }
                self.isLoading = false
            }
        }
    }
}
