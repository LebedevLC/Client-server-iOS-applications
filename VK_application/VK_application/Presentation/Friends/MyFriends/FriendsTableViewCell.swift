//
//  FriendsTableViewCell.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 10.07.2021.
//

import UIKit

final class FriendsTableViewCell: UITableViewCell {
    
    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var viewImageView: UIView!
    @IBOutlet private var cityLabel: UILabel!
    
    static let reusedIdentifire = "FriendsTableViewCell"
    
    var avatarTapped: (() -> Void)?
    var indexPathCell: IndexPath?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.configureStatic()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
        nameLabel.text = nil
        cityLabel.text = nil
    }
    
    func configure(friend: FriendModel, indexPathFromTable: IndexPath) {
        avatarImageView.layer.borderColor = UIColor.random().cgColor  // просто для красоты
        avatarImageView.image = UIImage(named: friend.avatarName)
        nameLabel.text = friend.name
        cityLabel.text = friend.city
        indexPathCell = indexPathFromTable
    }
    
    func configureStatic() {
        avatarImageView.layer.borderWidth = 2
        avatarImageView.layer.cornerRadius = 37
        avatarImageView.layer.borderWidth = 2
        viewImageView.layer.cornerRadius = 37
        viewImageView.layer.backgroundColor = UIColor.clear.cgColor
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tappedImage))
        avatarImageView.addGestureRecognizer(tap)
        avatarImageView.isUserInteractionEnabled = true
        }

    @objc func tappedImage() {
        UIView.animateKeyframes(
            withDuration: 0.3,
            delay: 0,
            options: [],
            animations: {
                UIView.addKeyframe(withRelativeStartTime: 0,
                                   relativeDuration: 0.5,
                                   animations: {
                                    self.avatarImageView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                                   })
                UIView.addKeyframe(withRelativeStartTime: 0.5,
                                   relativeDuration: 0.6,
                                   animations: {
                                    self.avatarImageView.transform = .identity
                                   })
            },
            // реализовать переход по индексу ячейки
            completion: {_ in
                self.avatarTapped?()
            })
    }
    
}




