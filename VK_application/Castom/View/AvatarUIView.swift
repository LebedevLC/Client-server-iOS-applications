//
//  NewAvatarView.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 05.08.2021.
//

import UIKit

final class AvatarUIView: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.shadowOpacity = 0.9
        self.layer.cornerRadius = self.frame.width/2
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 3
        self.layer.shadowOffset = .zero
    }
}
