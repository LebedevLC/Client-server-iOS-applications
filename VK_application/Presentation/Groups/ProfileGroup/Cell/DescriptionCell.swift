//
//  DescriptionCell.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 15.09.2021.
//

import UIKit

class DescriptionCell: UITableViewCell {
    
    static let reusedIdentifier = "DescriptionCell"
    
    var buttonTapped: (() -> Void)?
    
    @IBOutlet var subscribeCountLabel: UILabel!
    @IBOutlet var fullDescriptionLabel: UILabel!
    @IBOutlet var descriptionButton: UIButton!

    
    override func prepareForReuse() {
        super.prepareForReuse()
        subscribeCountLabel.text = nil
        fullDescriptionLabel.text = nil
    }
    

    @IBAction func TapedDescriptionButton(_ sender: UIButton) {
        self.buttonTapped?()
    }
    
    func configure(group: GroupModel) {
        subscribeCountLabel.text = String(group.subscribersCount) + " подписчиков"
        fullDescriptionLabel.text = group.fullDescription
    }
    
}
