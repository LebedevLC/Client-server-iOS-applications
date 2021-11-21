//
//  NewsCellText.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 27.07.2021.
//

import UIKit

final class NewsCellText: UITableViewCell {
    
    @IBOutlet var labelText: UILabel!
    @IBOutlet weak var showMoreLabel: UILabel!
    
    let stringSetup = AttributedStringSetup()
    var showMore: NSAttributedString?
    var showLess: NSAttributedString?
    
    static let reusedIdentifier = "NewsCellText"
    
    private var isMore: Bool = false
    
    var controlTapped: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        showMore = stringSetup.simpleStringSetup(text: "Показать больше", size: 14, color: .link)
        showLess = stringSetup.simpleStringSetup(text: "Скрыть", size: 14, color: .link)
        setSingleTap()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        labelText.text = nil
        showMoreLabel.isHidden = true
    }
    
    func configure(text: String) {
        labelText.text = text
        if !isMore {
            showMoreLabel.attributedText = showMore
        } else {
            showMoreLabel.attributedText = showLess
            }
        
        if labelText.text == "" || text.count <= 200 {
            showMoreLabel.isHidden = true
        } else {
            showMoreLabel.isHidden = false
        }
    }
    
    private func setSingleTap() {
        let singleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleSingleTap))
        singleTap.numberOfTapsRequired = 1
        self.showMoreLabel.addGestureRecognizer(singleTap)
    }
    
    @IBAction func handleSingleTap(sender: UITapGestureRecognizer) {
        if isMore {
            labelText.numberOfLines = 7
            showMoreLabel.attributedText = showMore
        } else {
            labelText.numberOfLines = 0
            showMoreLabel.attributedText = showLess
        }
        controlTapped?()
        isMore.toggle()
    }
    
}
