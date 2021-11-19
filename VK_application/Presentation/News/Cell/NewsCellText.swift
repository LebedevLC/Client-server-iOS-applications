//
//  NewsCellText.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 27.07.2021.
//

import UIKit

final class NewsCellText: UITableViewCell {
    
    @IBOutlet var labelText: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    
    static let reusedIdentifier = "NewsCellText"
    
    private var isMore: Bool = true
    
    var controlTapped: (() -> Void)?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        labelText.text = nil
        moreButton.isHidden = true
    }
    
    func configure(text: String) {
        labelText.text = text
        if text.count <= 200 || labelText.text == "" {
            moreButton.isHidden = true
        } else { moreButton.isHidden = false }
    }
    
    @IBAction func moreButtonTapped(_ sender: Any) {
        if isMore {
            labelText.numberOfLines = 7
            moreButton.setAttributedTitle(stringSetup(text: "Показать больше"), for: .normal)
        } else {
            labelText.numberOfLines = 0
            moreButton.setAttributedTitle(stringSetup(text: "Скрыть"), for: .normal)
        }
        isMore.toggle()
        controlTapped?()
    }
    
    private func stringSetup(text: String) -> NSAttributedString {
         let font = UIFont.systemFont(ofSize: 14)
         let attributes = [NSAttributedString.Key.font: font,
                           NSAttributedString.Key.foregroundColor: UIColor.link]
         let attributedText = NSAttributedString(string: text, attributes: attributes)
         return attributedText
     }
}
