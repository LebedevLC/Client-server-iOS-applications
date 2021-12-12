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
    
    private let image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.black.cgColor
        image.backgroundColor = .clear
        image.tintColor = .clear
        image.image = UIImage(named: "photoHolder")
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        image.image = UIImage(named: "photoHolder")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 8
        image.backgroundColor = .cyan
        image.frame = CGRect(
            x: 0,
            y: 0,
            width: 130,
            height: 130)
    }
    
    func configure(with model: PhotoesItems) {
        // выбираем не самую "тяжелую" картинку для предпросмотра
        let url = URL(string: model.sizesArray[4])
        image.kf.setImage(with: url, placeholder: nil, options: [.transition(ImageTransition.fade(1) ) ] )
    }
}
