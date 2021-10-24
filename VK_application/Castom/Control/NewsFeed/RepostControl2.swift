//
//  RepostControl2.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 26.07.2021.
//

import UIKit

final class RepostControl2: UIControl {
    
    var controlTapped: (() -> Void)?
    private var repostButton = UIButton()
    private var repostCountLabel = UILabel()
    private var repostCounter: Int = 0
    
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
        repostButton.frame = bounds
    }
    
    private func setView() {
        self.addSubview(repostButton)
        self.addSubview(repostCountLabel)
        self.repostButton.addTarget(self, action: #selector(tapControl(_:)), for: .touchUpInside)
        repostButton.tintColor = UIColor.black
        repostButton.setImage(UIImage(systemName: "arrowshape.turn.up.right"), for: .normal)
        repostButton.setImage(UIImage(systemName: "arrowshape.turn.up.right.fill"), for: .selected)
        repostCountLabel.textColor = UIColor.black
        repostCountLabel.translatesAutoresizingMaskIntoConstraints = false
        repostCountLabel.trailingAnchor.constraint(equalTo: repostButton.leadingAnchor, constant: -2).isActive = true
        repostCountLabel.centerYAnchor.constraint(equalTo: repostButton.centerYAnchor).isActive = true
    }
    
    func configure(isRepost: Bool, repostCount: Int) {
        repostCounter = repostCount
        repostCountLabel.text = String(repostCount)
        repostButton.isSelected = isRepost
    }
    
    @objc func tapControl(_ sender: UIButton) {
        controlTapped?()
        animatedLabel(repostCount: repostCounter)
    }
    
    private func animatedLabel(repostCount: Int) {
        UIView.transition(with: repostCountLabel,
                          duration: 0.2,
                          options: .transitionFlipFromLeft,
                          animations: { [unowned self] in
                            self.repostCountLabel.text = String(repostCount)}
        )
    }
    
}
