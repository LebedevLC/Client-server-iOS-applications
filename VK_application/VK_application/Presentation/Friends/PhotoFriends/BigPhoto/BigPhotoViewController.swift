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
        bigView.delegate = self
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.isHidden = false
    }
    
}

// delegate
extension BigPhotoViewController: BigPhotoViewDelegate {
    func action() {
        tabBarController?.tabBar.isHidden.toggle()
        navigationController?.navigationBar.isHidden.toggle()
    }
}



