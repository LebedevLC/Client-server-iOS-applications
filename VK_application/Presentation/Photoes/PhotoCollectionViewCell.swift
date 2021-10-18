//
//  PhotoCollectionViewCell.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 11.07.2021.
//

import UIKit
import Kingfisher

final class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var photoNameLabel: UILabel!
    @IBOutlet var likeControl2: LikeControl2!
    @IBOutlet var newAvatarView: AvatarUIView!
    
    static let identifier = "PhotoCollectionViewCell"
    
    var likeTapped: (() -> Void)?
    var isLike = false

    override func layoutSubviews() {
        super.layoutSubviews()
        self.configureStatic()
    }
        
    override func prepareForReuse() {
        super.prepareForReuse()
        self.photoImageView.image = nil
        self.photoNameLabel.text = nil
    }
    
    func configureStatic() {
        photoImageView.layer.borderWidth = 1
        photoImageView.layer.borderColor = UIColor.white.cgColor
        newAvatarView.layer.cornerRadius = 10
        photoImageView.layer.cornerRadius = 10
    }
    
    func configure(photoModel: PhotoesItems) {
        photoNameLabel.text = photoModel.text
        let url = URL(string: photoModel.singleSizePhoto)
        self.photoImageView.kf.setImage(with: url, placeholder: nil, options: [.transition(ImageTransition.fade(1) ) ] )
        guard photoModel.user_likes == 0 || photoModel.user_likes == 1 else { return }
        if photoModel.user_likes == 1 {
            isLike = true
        } else {
            isLike = false
        }

        likeControl2.configure(isLike: isLike,
                               likeCount: photoModel.likesCount
        )
        
//        likeControl2.controlTapped = {[weak self] in
//            self?.likeTapped?()
//        }
    }
    
}
