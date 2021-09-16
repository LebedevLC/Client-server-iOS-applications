//
//  BigPhotoViewController.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 31.07.2021.
//


import UIKit

class BigPhotoViewController: UIViewController {

    @IBOutlet var bigView: BigPhotoView!
    
    var bigTappedVC: ((Int) -> IndexPath)?
    var bigPhotoes: [PhotoModel] = []
    var sourceIndexPath: IndexPath = IndexPath()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bigView.photoes = bigPhotoes.map({$0.fileName})
        bigView.visibleIndex = sourceIndexPath.item
        bigView.namePhoto = bigPhotoes.map({$0.name})
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.isHidden = false
    }
    
}

// 2 часа на первую версию, чтобы передавать сюда изображения
// 3 часа ночью и 1/2 часа утром на вторую версию чтобы передать сюда изображения (утром думается лучше)
// 1 чвс на анимацию transform при перелистывании
// 1 час на добавление, передачу и анимацию названия фото
// 1/4 чвса на исправление бага с исчезающим фото


