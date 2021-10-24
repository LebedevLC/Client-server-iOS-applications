//
//  GroupCellLogo.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 11.09.2021.
//

import UIKit

class GroupCellLogo: UITableViewCell {

    @IBOutlet var nameGroupLabel: UILabel!
    @IBOutlet var shortDescriptionLabel: UILabel!
    @IBOutlet var avatarImage: UIImageView!
    @IBOutlet var messageButton: UIButton!
    @IBOutlet var subscribeControl: SubscribeControl!
    @IBOutlet var repostControl: RepostControl!
    @IBOutlet var notificationControl: NotificationControl!
    
    static let reusedIdentifier = "GroupCellLogo"
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImage.translatesAutoresizingMaskIntoConstraints = true
        avatarImage.layer.cornerRadius = avatarImage.frame.width/2
        messageButton.layer.cornerRadius = 8
    }
    
    @IBAction func tapMessageButton(_ sender: Any) {
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImage.image = nil
        nameGroupLabel.text = nil
        shortDescriptionLabel.text = nil
        
    }
    
    func configure(group: GroupsItems) {
        let url = URL(string: group.photo_100)
        avatarImage.kf.setImage(with: url)
        shortDescriptionLabel.text = group.screen_name
        nameGroupLabel.text = group.name
        
        // test parameters
        subscribeControl.configure(isSubscribe: Bool.random())
        repostControl.configure(isRepost: Bool.random())
        notificationControl.configure(isNotification: Bool.random())
    }
}
