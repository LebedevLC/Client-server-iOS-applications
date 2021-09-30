//
//  AddFriendCell.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 13.07.2021.
//

import UIKit

final class AddFriendCell: UITableViewCell {
    
    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var cityLabel: UILabel!
    
    static let reusedIdentifier = "AddFriendCell"
    
    var avatarTapped: (() -> Void)?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.configureStatic()
    }
   
    override func prepareForReuse() {
        super.prepareForReuse()
        self.nameLabel.text = nil
        self.avatarImageView.image = nil
        self.cityLabel.text = nil
    }

    func configure(friend: FriendModel) {
        avatarImageView.image = UIImage(named: friend.avatarName)
        nameLabel.text = friend.name
        cityLabel.text = friend.city
    }
    
    private func configureStatic() {
        avatarImageView.layer.borderWidth = 2
        avatarImageView.layer.cornerRadius = 50
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.layer.backgroundColor = UIColor.clear.cgColor
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tappedImage))
        avatarImageView.addGestureRecognizer(tap)
        avatarImageView.isUserInteractionEnabled = true
        }

    @objc func tappedImage() {
        UIView.animateKeyframes(withDuration: 0.6,
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
