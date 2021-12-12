//
//  FriendsTableViewCell.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 10.07.2021.
//

import UIKit
import Kingfisher
import SwiftUI

final class FriendsTableViewCell: UITableViewCell {
    
    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var viewImageView: UIView!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet private var onlineLabel: UILabel!
    
    static let reusedIdentifire = "FriendsTableViewCell"
    
    var avatarTapped: (() -> Void)?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.configureStatic()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
        nameLabel.text = nil
        onlineLabel.text = nil
        cityLabel.text = nil
        cityLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    }
    
    func configure(friend: FriendsItems) {
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        nameLabel.text = friend.first_name + " " + friend.last_name
        if friend.online == 0 {
            onlineLabel.text = "Не в сети"
        } else {
            onlineLabel.text = "В сети"
        }
        if friend.title == nil {
            cityLabel.text = onlineLabel.text
            cityLabel.font = onlineLabel.font
            onlineLabel.text = nil
        } else {
            cityLabel.text = friend.title
        }
        let url = URL(string: friend.photo_100)
        DispatchQueue.main.async() { [weak self] in
            self?.avatarImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "heart"))
                }
    }
    
    func configureStatic() {
        avatarImageView.layer.borderWidth = 2
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height/2
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
