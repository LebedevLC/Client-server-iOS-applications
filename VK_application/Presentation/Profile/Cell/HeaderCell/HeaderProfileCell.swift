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
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var moreInfo: UIButton!
    @IBOutlet var friendButton: UIButton!
    @IBOutlet var giftButton: UIButton!
    @IBOutlet var notifyButton: UIButton!
    
    private let dateFormatterRU = DateFormatterRU()
    
    var moreInfoTapped: (() -> Void)?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureStatic()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
        nameLabel.text = nil
        statusLabel.text = nil
    }
    
    func configure(model: HeaderCellModel) {
        let url = URL(string: model.avatar)
        let status = model.status
        let name = model.name
        
        nameLabel.text = name
        avatarImageView.kf.setImage(with: url)
        if status != "" {
            statusLabel.text = status
        } else {
            statusLabel.text = """
                Последний раз был/а в сети:
                \(model.date)
                """
        }
    }
    
    private func configureStatic() {
        avatarView.layer.borderWidth = 2
        avatarView.layer.borderColor = UIColor.white.cgColor
        moreInfo.layer.cornerRadius = 10
    }

    @IBAction func moreInfoButtonTapped(_ sender: UIButton) {
        self.moreInfoTapped?()
    }
}
