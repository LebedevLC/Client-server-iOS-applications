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
    var photoItems: [PhotoesItems] = []
    var sourceIndexPath: IndexPath = IndexPath()
    var photoInfo = [Int:(String, String, Int, Int, Int)]()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bigView.photoInfo = photoInfo
        bigView.visibleIndex = sourceIndexPath.item
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
