//
//  BigImageNewsVC.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 08.08.2021.
//

import UIKit

class BigImageNewsVC: UIViewController{
    
    @IBOutlet weak var bigImageView: UIImageView!
    
    var imageName: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = true
        setImage()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.isHidden = false
    }
    
    private func setImage() {
        bigImageView.image = UIImage(named: imageName)
        bigImageView.frame = UIScreen.main.bounds
        bigImageView.backgroundColor = UIColor.clear
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissFullscreenImage))
        bigImageView.addGestureRecognizer(tap)
    }
    
    // по тапу можно вернуться назад
    @objc func dismissFullscreenImage(sender: UITapGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
