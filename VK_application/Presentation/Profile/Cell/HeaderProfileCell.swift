//
//  HeaderProfileCell.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 14.10.2021.
//

import UIKit

class HeaderProfileCell: UITableViewCell {
    
    static let reusedIdentifier = "HeaderProfileCell"

    @IBOutlet var avatarView: UIView!
    @IBOutlet var cellView: UIView!
    @IBOutlet var avatarImageView: AvatarImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var editButton: UIButton!
    @IBOutlet var photoButton: UIButton!
    @IBOutlet var postButton: UIButton!
    @IBOutlet var cameraButton: UIButton!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureStatic()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
        nameLabel.text = nil
        cityLabel.text = nil
    }
    
    func configure(accountItems: AccountItems, photoModel: PhotoesItems) {
        let url = URL(string: photoModel.singleSizePhoto)
        DispatchQueue.main.async() { [weak self] in
            self?.avatarImageView.kf.setImage(with: url)
                }
        nameLabel.text = accountItems.first_name + " " + accountItems.last_name
        cityLabel.text = accountItems.home_town
    }
    
    private func configureStatic() {
        avatarView.layer.borderWidth = 2
        avatarView.layer.borderColor = UIColor.white.cgColor
        editButton.layer.cornerRadius = 10
    }

}
