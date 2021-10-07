//
//  NewsViewController.swift
//  VK_application
//
//  Шикарно с третьего раза Created by Сергей Чумовских  on 23.07.2021.
//

import UIKit

final class NewsViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    private var news: [NewsModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: NewsCellHeader2.reusedIdentifier, bundle: nil),
                               forCellReuseIdentifier: NewsCellHeader2.reusedIdentifier)
        
        tableView.register(UINib(nibName: NewsCellText.reusedIdentifier, bundle: nil),
                               forCellReuseIdentifier: NewsCellText.reusedIdentifier)
        
        tableView.register(UINib(nibName: NewsCellPhoto.reusedIdentifier, bundle: nil),
                               forCellReuseIdentifier: NewsCellPhoto.reusedIdentifier)
        
        tableView.register(UINib(nibName: NewsCellFooter.reusedIdentifier, bundle: nil),
                               forCellReuseIdentifier: NewsCellFooter.reusedIdentifier)
        
        let storage = NewsStorage()
        news = storage.news
    }
    
    // переопределяем сегу для переходов
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            // Проверям сегу
            segue.identifier == "showBigImageNews",
            // Кастим
            let destinationController = segue.destination as? BigImageNewsVC,
            let indexPath = sender as? IndexPath
        else { return }
        // Отправляем
        destinationController.imageName = news[indexPath.section].newsImageName
    }
    
}

//MARK: - Extension UITableView

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        news.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        
// первая ячейка (хедер)
        case 0:
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: NewsCellHeader2.reusedIdentifier,
                                                         for: indexPath) as? NewsCellHeader2
            else {
                return UITableViewCell()
            }
            let newsData = news[indexPath.section]
            let friend = newsData.user[0]
            cell.configure(friend: friend, newsData: newsData)
            return cell
            
// вторая ячейка (текст)
        case 1:
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: NewsCellText.reusedIdentifier,
                                                         for: indexPath) as? NewsCellText
            else {
                return UITableViewCell()
            }
            let news = news[indexPath.section]
            cell.configure(news: news)
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
            let news = news[indexPath.section]
            cell.configure(news: news)
            // обработка замыкания в ячейке
            cell.controlTapped = { [weak self] in
                self?.performSegue(withIdentifier: "showBigImageNews", sender: indexPath)}
            return cell
            
// четвертая яейка (футер)
        default:
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: NewsCellFooter.reusedIdentifier,
                                                         for: indexPath) as? NewsCellFooter
            else {
                return UITableViewCell()
            }
            cell.configure(newsData: news[indexPath.section].newsDataModel[0])
            cell.likeTapped = { [weak self] in
                self?.news[indexPath.section].newsDataModel[0].newsIsLike.toggle()
                self?.tableView.reloadSections(IndexSet(integer: indexPath.section), with: .automatic)
            }
            cell.repostTapped = { [weak self] in
                self?.news[indexPath.section].newsDataModel[0].newsIsRepost.toggle()
                self?.tableView.reloadSections(IndexSet(integer: indexPath.section), with: .automatic)
            }
            cell.commentTapped = { [weak self] in
                self?.news[indexPath.section].newsDataModel[0].newsIsComment.toggle()
                self?.tableView.reloadSections(IndexSet(integer: indexPath.section), with: .automatic)
            }
            return cell
        }
    }
    
}
