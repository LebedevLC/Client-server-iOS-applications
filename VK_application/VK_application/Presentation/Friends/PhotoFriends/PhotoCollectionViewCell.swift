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
    
    func configure(photoModel: PhotoModel) {
        photoNameLabel.text = photoModel.name
        photoImageView.image = UIImage(named: photoModel.fileName)
        likeControl2.configure(isLike: photoModel.isLike,
                               likeCount: photoModel.likeCount
        )
        likeControl2.controlTapped = {[weak self] in
            self?.likeTapped?()
        }
    }
    
}
