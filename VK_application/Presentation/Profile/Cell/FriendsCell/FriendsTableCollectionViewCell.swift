//
//  FriendsTableCollectionViewCell.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 24.10.2021.
//

import UIKit

class FriendsTableCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "FriendsTableCollectionViewCell"
    
    private let friendName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let friendImage: UIImageView = {
        let image = UIImageView ()
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.black.cgColor
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(friendName)
        contentView.addSubview(friendImage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        friendImage.frame = CGRect(
            x: 15,
            y: 0,
            width: 75,
            height: 75)
        friendImage.layer.cornerRadius = friendImage.frame.height/2
        friendName.frame = CGRect(
            x: 0,
            y: contentView.frame.size.height-35,
            width: 100,
            height: 35)
    }
    
    func configure(with model: CollectionTableCellModel) {
        let url = URL(string: model.imageName)
        DispatchQueue.main.async() { [weak self] in
            self?.friendImage.kf.setImage(with: url)
                }
        friendName.text = model.title
    }
}
