//
//  NewsCellText.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 27.07.2021.
//

import UIKit

final class NewsCellText: UITableViewCell {
    
    @IBOutlet var labelText: UILabel!
    
    static let reusedIdentifier = "NewsCellText"
    
    private var isMore: Bool = false
    
    var controlTapped: (() -> Void)?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setSingleTap()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        labelText.text = nil
    }
    
    func configure(text: String) {
        labelText.text = text
    }

    private func setSingleTap() {
        let singleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleSingleTap))
        singleTap.numberOfTapsRequired = 1
        self.labelText.addGestureRecognizer(singleTap)
    }

    // Разворачиваем или сворачиваем длинный текст
    @IBAction func handleSingleTap(sender: UITapGestureRecognizer) {
        if isMore {
            labelText.numberOfLines = 8
        }
        else {
            labelText.numberOfLines = 0
        }
        isMore.toggle()
        controlTapped?()
    }
}
