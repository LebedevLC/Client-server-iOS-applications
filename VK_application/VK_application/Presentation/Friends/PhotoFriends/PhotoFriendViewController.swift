//
//  PhotoFriendViewController.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 11.07.2021.
//

import UIKit

final class PhotoFriendViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    private var afPhotoes = PhotoesGetAll()
    private var photoesAloma : [PhotoesItems] = []
    private var photoXURL : [URL] = []
    private var photoInfo = [Int : (String, URL, Int, Int, Int)]()
    
    var userID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        getPhotoes()
    }
    
    // делаем запрос photos.getAll
    private func getPhotoes() {
        afPhotoes.getPhotoesAll(ownerID: userID!) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let photoes):
                self.photoesAloma = photoes
                guard photoes.count != 0 else {
                    print("friend count photoes = 0")
                    return}
                for i in 0...self.photoesAloma.count - 1 {
                    for j in 0...self.photoesAloma[i].sizes.count - 1 {
                        if self.photoesAloma[i].sizes[j].type.contains("x") {
                            self.photoXURL.append(self.photoesAloma[i].sizes[j].url)
                            self.photoInfo[i] = (self.photoesAloma[i].text,
                                                 // URL sizeX Image
                                                 self.photoesAloma[i].sizes[j].url,
                                                 // are you like? 1/0
                                                 self.photoesAloma[i].likes.user_likes,
                                                 // likes count
                                                 self.photoesAloma[i].likes.count,
                                                 // reposts count
                                                 self.photoesAloma[i].reposts.count)
                        }
                    }
                }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure:
                print("getPhotoesAll FAIL")
            }
        }
    }
    
    // Передача на следующий контроллер всех изображений объекта и IndexPath выделенного
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            // Проверям сегу
            segue.identifier == "toBigPhoto",
            // Кастим
            let destinationController = segue.destination as? BigPhotoViewController,
            // Сохраняем индексы выбранных изображений
            let indexPaths = collectionView.indexPathsForSelectedItems
        else { return }
        // Кастим чтобы получить не массив
        let indexPath = indexPaths[0] as IndexPath
        // Отправляем
        destinationController.photoInfo = photoInfo
        destinationController.sourceIndexPath = indexPath
    }
    
}

//MARK: - Extension CollectionView (DataSource/Delegate)
extension PhotoFriendViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoXURL.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier,
                                                      for: indexPath) as! PhotoCollectionViewCell
        cell.configure(photoModel: photoesAloma[indexPath.item], photo: photoXURL[indexPath.item])
//        cell.likeTapped = { [weak self] in
//            self?.photoXURL[indexPath.item].isLike.toggle()
//                collectionView.reloadSections(IndexSet(integer: 0)) //UIView.performWithoutAnimation
//        }
        return cell
    }
    
}
