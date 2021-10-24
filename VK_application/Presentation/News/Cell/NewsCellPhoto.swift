//
//  NewsCell.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 23.07.2021.
//

import UIKit
import Kingfisher

final class NewsCellPhoto: UITableViewCell {
    
    @IBOutlet private var newsImageView: UIImageView!
    
    static let reusedIdentifier = "NewsCellPhoto"
    // замыкание для перехода по сеге
    var controlTapped: (() -> Void)?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.configureStatic()
        setSingleTap()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.newsImageView.image = nil
    }
    
    func configure(wall: WallItems, group: GroupsItems) {
        let sizeLast = wall.attachments[0].photo.sizes.endIndex-1
        let url = URL(string: wall.attachments[0].photo.sizes[sizeLast].url)
        newsImageView.kf.setImage(with: url, placeholder: nil, options: [.transition(ImageTransition.fade(1) ) ] )
    }
    
    private func configureStatic() {
        newsImageView.isUserInteractionEnabled = true
        //        newsImageView.layer.borderWidth = 1
        //        newsImageView.layer.borderColor = UIColor.black.cgColor
    }
    
    // добавляем обработку нажатия на фото
    func setSingleTap() {
        let singleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleSingleTap))
        singleTap.numberOfTapsRequired = 1
        newsImageView.addGestureRecognizer(singleTap)
    }
    
    // логика нажатия
    @IBAction func handleSingleTap(sender: UITapGestureRecognizer) {
        //  performSegue "showBigImageNews" вызывается в контроллере
        controlTapped?()
    }
    
    
}
