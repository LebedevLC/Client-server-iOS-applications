//
//  LikeControl2.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 18.07.2021.
//

import UIKit

final class LikeControl2: UIControl {
    
    var controlTapped: (() -> Void)?
    private var likeButton = UIButton()
    private var likeCountLabel = UILabel()
    private var likeCounter: String = ""
    
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
        likeButton.frame = bounds
    }
    
    private func setView() {
        self.addSubview(likeButton)
        self.addSubview(likeCountLabel)
        self.likeButton.addTarget(self, action: #selector(tapControl(_:)), for: .touchUpInside)
        likeButton.tintColor = UIColor.red
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        likeCountLabel.textColor = UIColor.red
        likeCountLabel.translatesAutoresizingMaskIntoConstraints = false
        likeCountLabel.trailingAnchor.constraint(equalTo: likeButton.leadingAnchor, constant: -2).isActive = true
        likeCountLabel.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor).isActive = true
    }
    
    func configure(isLike: Bool, likeCount: Int) {
        switch likeCount {
        case 0..<1000:
            likeCounter = String(likeCount)
        case 1000..<1_000_000:
            likeCounter = String(likeCount/1000) + "K"
        default:
            likeCounter = ""
        }
        likeCountLabel.text = likeCounter
        likeButton.isSelected = isLike
    }
    
    @objc func tapControl(_ sender: UIButton) {
        controlTapped?()
        animatedLabel(likeCount: likeCounter)
    }
    
    private func animatedLabel(likeCount: String) {
        UIView.transition(with: likeCountLabel,
                          duration: 0.2,
                          options: .transitionFlipFromTop,
                          animations: { [unowned self] in
                            self.likeCountLabel.text = likeCount}
        )
    }
}
