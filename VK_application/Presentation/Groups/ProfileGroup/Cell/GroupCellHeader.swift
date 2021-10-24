//
//  Header.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 13.08.2021.
//

import UIKit

final class GroupCellHeader: UITableViewCell {
    
    @IBOutlet var headerImage: UIImageView!
    
    static let reusedIdentifier = "GroupCellHeader"
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headerImage.frame = bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        headerImage.image = nil
    }
    
    func configure(group: GroupsItems) {
        let url = URL(string: group.photo_200)
        headerImage.kf.setImage(with: url)
    }
    
}
