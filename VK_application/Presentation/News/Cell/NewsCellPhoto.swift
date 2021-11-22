//
//  NewsCell.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 23.07.2021.
//

import UIKit
import Kingfisher

final class NewsCellPhoto: UITableViewCell {
    
    @IBOutlet private var newsImageView: UIImageView!
    
    static let reusedIdentifier = "NewsCellPhoto"

    var controlTapped: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureStatic()
        setSingleTap()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.newsImageView.image = nil
    }
    
    func configure(attachments: Attachments) {
        guard let photo = attachments.photo?.sizes else { return }
        let sizeLast = photo.endIndex - 1
        let url = URL(string: photo[sizeLast].url ?? "")
        newsImageView.kf.setImage(with: url, placeholder: nil, options: [.transition(ImageTransition.fade(1) ) ] )
    }
    
    private func configureStatic() {
        newsImageView.isUserInteractionEnabled = true
    }
    
    func setSingleTap() {
        let singleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleSingleTap))
        singleTap.numberOfTapsRequired = 1
        newsImageView.addGestureRecognizer(singleTap)
    }
    
    @IBAction func handleSingleTap(sender: UITapGestureRecognizer) {
        controlTapped?()
    }
    
}
