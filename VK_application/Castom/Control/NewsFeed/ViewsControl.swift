//
//  ViewsControl.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 26.07.2021.
//

import UIKit

final class ViewsControl: UIControl {
    
    private var viewsButton = UIButton()
    private var viewsCountLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        viewsButton.frame = bounds
    }
    
    private func setView() {
        self.addSubview(viewsButton)
        self.addSubview(viewsCountLabel)
        viewsButton.tintColor = UIColor.black
        viewsButton.setImage(UIImage(systemName: "eye"), for: .normal)
        viewsButton.setImage(UIImage(systemName: "eye.fill"), for: .selected)
        viewsCountLabel.textColor = UIColor.black
        viewsCountLabel.translatesAutoresizingMaskIntoConstraints = false
        viewsCountLabel.trailingAnchor.constraint(equalTo: viewsButton.leadingAnchor, constant: -2).isActive = true
        viewsCountLabel.centerYAnchor.constraint(equalTo: viewsButton.centerYAnchor).isActive = true
    }
    
    func configure(viewsCount: Int) {
        viewsButton.isSelected = true
        switch viewsCount {
        case 0..<1000:
            viewsCountLabel.text = String(viewsCount)
        case 1000..<1_000_000:
            viewsCountLabel.text = String(viewsCount/1000) + "K"
        default:
            viewsCountLabel.text = "1"
        }
    }
}
