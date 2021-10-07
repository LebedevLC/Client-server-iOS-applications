//
//  PhotoFriendViewController.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 11.07.2021.
//

import UIKit
import SwiftUI

final class PhotoFriendViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    private var afPhotoes = PhotoesGetAll()
    private var photoesAloma : [PhotoesItems] = []
    // отдельно ссылки на фото размера "х"
    private var photoXURL : [String] = []
    // словарь для удобной передачи дальше
    private var photoInfo = [Int : (String, String, Int, Int, Int)]()
    
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
                    return }
                
                // записываем в массив только фотографии типа "X"
                for i in 0...self.photoesAloma.count - 1 {
                    for j in 0...self.photoesAloma[i].sizesArray.count - 1{
                        if self.photoesAloma[i].sizesArray[j].contains("x+") {
                            // фото у нас идёт раньше на одну позицию, поэтому [j-1]
                            guard (j - 1) >= 0 else {
                                print("FAIL! No URL for photo")
                                return}
                            self.photoXURL.append(self.photoesAloma[i].sizesArray[j-1])
                            self.photoInfo[i] = (self.photoesAloma[i].text,
                                                 // URL sizeX Image
                                                 self.photoesAloma[i].sizesArray[j-1],
                                                 // are you like? 1/0
                                                 self.photoesAloma[i].user_likes,
                                                 // likes count
                                                 self.photoesAloma[i].likesCount,
                                                 // reposts count
                                                 self.photoesAloma[i].repostCount)
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
