//
//  PhotoFriendViewController.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 11.07.2021.
//

import UIKit

final class PhotoFriendViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var photoes: [PhotoModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
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
        destinationController.bigPhotoes = photoes
        destinationController.sourceIndexPath = indexPath
    }
    
}

//MARK:- Extension CollectionView (DataSource/Delegate)
extension PhotoFriendViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier,
                                                      for: indexPath) as! PhotoCollectionViewCell
        let photo = photoes[indexPath.item]
        cell.configure(photoModel: photo)
        cell.likeTapped = { [weak self] in
            self?.photoes[indexPath.item].isLike.toggle()
                collectionView.reloadSections(IndexSet(integer: 0)) //UIView.performWithoutAnimation
        }
        return cell
    }
    
}
