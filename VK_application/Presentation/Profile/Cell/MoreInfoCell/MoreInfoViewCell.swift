//
//  MoreInfoViewCell.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 31.10.2021.
//

import UIKit

class MoreInfoViewCell: UITableViewCell {
    
    static let reusedIdentifier = "MoreInfoViewCell"

    @IBOutlet weak var atributView: UIView!
    @IBOutlet weak var nameAtributLabel: UILabel!
    @IBOutlet weak var textAtributLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameAtributLabel.text = nil
        textAtributLabel.text = nil
    }
    
    func configure(nameAtribut: String, textAtribut: String) {
        nameAtributLabel.text = nameAtribut
        textAtributLabel.text = textAtribut
    }
}
