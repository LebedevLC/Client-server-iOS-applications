//
//  CommentControl2.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 26.07.2021.
//


import UIKit

final class CommentControl2: UIControl {
    
    var controlTapped: (() -> Void)?
    private var commentButton = UIButton()
    
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
        commentButton.frame = bounds
    }
    
    private func setView() {
        self.addSubview(commentButton)
        self.commentButton.addTarget(self, action: #selector(tapControl(_:)), for: .touchUpInside)
        commentButton.tintColor = UIColor.black
        commentButton.setImage(UIImage(systemName: "text.bubble"), for: .normal)
        commentButton.setImage(UIImage(systemName: "text.bubble.fill"), for: .selected)
    }
    
    func configure(isComment: Bool) {
        commentButton.isSelected = isComment
    }
    
    @objc func tapControl(_ sender: UIButton) {
        controlTapped?()
    }
    
}
