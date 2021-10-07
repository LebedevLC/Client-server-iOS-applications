//
//  FriendsTableViewCell.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 10.07.2021.
//

import UIKit
import Kingfisher

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
    
    func configure(friend: FriendsItems, indexPathFromTable: IndexPath) {
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        nameLabel.text = friend.first_name + " " + friend.last_name
//        cityLabel.text = friend.city
        cityLabel.text = "City"
        let url = URL(string: friend.photo_100)
        DispatchQueue.main.async() { [weak self] in
            self?.avatarImageView.kf.setImage(with: url)
                }
        indexPathCell = indexPathFromTable
    }
    
    func configureStatic() {
        avatarImageView.layer.borderWidth = 2
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height/2
        avatarImageView.layer.borderWidth = 2
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
            completion: {_ in
                self.avatarTapped?()
            })
    }
    
}




