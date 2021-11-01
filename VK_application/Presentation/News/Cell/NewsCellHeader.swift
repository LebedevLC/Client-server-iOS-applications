//
//  NewsCellHeader2.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 27.07.2021.
//

import UIKit

final class NewsCellHeader: UITableViewCell {
    
    @IBOutlet var cellView: UIView!
    @IBOutlet var avatarView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
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
        dateLabel.text = nil
    }
    
    func configure(avatar: String, name: String, date: String) {
        let url = URL(string: avatar)
        avatarView.kf.setImage(with: url)
        nameLabel.text = name
        dateLabel.text = date
        
    }
    
    private func configureStatic() {
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        avatarView.layer.cornerRadius = avatarView.frame.height/2
    }
}
