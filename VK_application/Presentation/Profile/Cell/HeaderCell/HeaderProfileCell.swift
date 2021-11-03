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
    
    func configure(accountItems: UsersGetItems, photo: String, friendCount: Int) {
        let queue = DispatchQueue.global(qos: .utility)
        queue.async{
            let url = URL(string: photo)
            let date = self.dateFormatterRU.ShowMeDate(date: accountItems.last_seen?.time ?? 0000000000)
            let firstName = accountItems.first_name ?? ""
            let lastName = accountItems.last_name ?? ""
            let status = accountItems.status ?? ""
            let name = firstName + " " + lastName
            let isFriend = accountItems.is_friend ?? 0
            let isMyFriend = Bool(isFriend as NSNumber)
            DispatchQueue.main.async {
                self.nameLabel.text = name
                self.avatarImageView.kf.setImage(with: url)
                if status == "" {
                    self.statusLabel.text = """
                    Последний раз был/а в сети
                    \(date)
                    """
                } else {
                    self.statusLabel.text = status
                }
            }
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
