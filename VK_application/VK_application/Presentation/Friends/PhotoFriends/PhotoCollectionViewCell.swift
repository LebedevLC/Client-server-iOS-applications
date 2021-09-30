//
//  PhotoCollectionViewCell.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 11.07.2021.
//

import UIKit

final class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var photoNameLabel: UILabel!
    @IBOutlet var likeControl2: LikeControl2!
    @IBOutlet var newAvatarView: NewAvatarView!
    
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
    
    func configure(photoModel: PhotoesItems, photo: URL) {
        photoNameLabel.text = photoModel.text
        let url = photo
        DispatchQueue.main.async() { [weak self] in
            self?.photoImageView.kf.setImage(with: url)
                }
        guard photoModel.likes.user_likes == 0 || photoModel.likes.user_likes == 1 else { return }
        if photoModel.likes.user_likes == 1 {
            isLike = true
        } else {
            isLike = false
        }
        
        likeControl2.configure(isLike: isLike,
                               likeCount: photoModel.likes.count
        )
//        likeControl2.controlTapped = {[weak self] in
//            self?.likeTapped?()
//        }
    }
    
}
