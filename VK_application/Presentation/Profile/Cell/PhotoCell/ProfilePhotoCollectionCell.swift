//
//  ProfilePhotoCollectionCell.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 25.10.2021.
//

import UIKit
import Kingfisher

class ProfilePhotoCollectionCell: UICollectionViewCell {
    
    static let identifier = "ProfilePhotoCollectionCell"
    
    private let Image: UIImageView = {
        let image = UIImageView ()
        image.contentMode = .scaleAspectFill
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.black.cgColor
        image.backgroundColor = .clear
        image.tintColor = .clear
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(Image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        Image.layer.masksToBounds = true
        Image.layer.cornerRadius = 8
        Image.backgroundColor = .cyan
        Image.frame = CGRect(
            x: 0,
            y: 0,
            width: 130,
            height: 130)
    }
    
    func configure(with model: PhotoesItems) {
        let url = URL(string: model.singleSizePhoto)
        Image.kf.setImage(with: url, placeholder: nil, options: [.transition(ImageTransition.fade(1) ) ] )
    }
}
