//
//  PhotoFriendViewController.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 11.07.2021.
//

import RealmSwift

final class PhotoesFriendVC: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    private var afPhotoes = PhotoesServices()
    private var photoesAloma: [PhotoesItems] = []
    // Словарь для удобной передачи дальше
    private var photoInfo = [Int: (String, String, Int, Int, Int)]()
    
    var userID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        getPhotoes()
    }
    
    // MARK: - DataBase
    
    // Делаем запрос в сеть для обновления БД
    private func getPhotoes() {
        guard let userID = userID else {
            print("UserID ERROR")
            return
        }
        afPhotoes.getPhotoesAll(ownerID: userID) {[weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.loadData(userID: userID)
                self.collectionView.reloadData()
            }
        }
    }
    
    // Загрузка данных из Realm
    private func loadData(userID: Int) {
        do {
            let realm = try Realm()
            // Чтение из БД по параметру "id" и фильтру "userID"
            let photoes = realm.objects(PhotoesItems.self).filter("id == %@", userID)
            guard photoes.count != 0 else {
                print("friend count photoes = 0")
                // уходим через алерт
                DefaultAlert.alert.okAlert(
                    view: self,
                    title: "Внимание",
                    message: "У данного пользователя нет изображений")
                {
                    self.navigationController?.popViewController(animated: true)
                }
                return
            }
            self.photoesAloma = Array(photoes)
            self.prepareDictForShowBigView()
        } catch { print(error) }
    }
    
    private func prepareDictForShowBigView() {
        for i in 0...self.photoesAloma.count - 1 {
            self.photoInfo[i] = (
                self.photoesAloma[i].text,
                // URL Image
                self.photoesAloma[i].singleSizePhoto,
                // are you like? 1/0
                self.photoesAloma[i].user_likes,
                // likes count
                self.photoesAloma[i].likesCount,
                // reposts count
                self.photoesAloma[i].repostCount)
        }
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == "toBigPhoto",
            let destinationController = segue.destination as? BigPhotoViewController,
            let indexPaths = collectionView.indexPathsForSelectedItems
        else { return }
        let indexPath = indexPaths[0] as IndexPath
        destinationController.photoInfo = photoInfo
        destinationController.sourceIndexPath = indexPath
    }
}

// MARK: - Extension CollectionView (DataSource/Delegate)

extension PhotoesFriendVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoesAloma.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier,
                                                      for: indexPath) as! PhotoCollectionViewCell
        cell.configure(photoModel: photoesAloma[indexPath.item])
        return cell
    }
    
}
