//
//  NewsCellHeader2.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 27.07.2021.
//

import UIKit

final class NewsCellHeader2: UITableViewCell {
    
    @IBOutlet var cellView: UIView!
    @IBOutlet var avatarView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var dataLabel: UILabel!
    
    static let reusedIdentifier = "NewsCellHeader2"
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.configureStatic()
        cellView.frame = bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarView.image = nil
        nameLabel.text = nil
        dataLabel.text = nil
    }
    
    func configure(wall: WallItems, group: GroupsItems) {
        let url = URL(string: group.photo_100)
        avatarView.kf.setImage(with: url)
        nameLabel.text = group.name
//        dataLabel.text = wall.date
        
    }
    
    private func configureStatic() {
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        avatarView.layer.cornerRadius = avatarView.frame.height/2
    }
}
