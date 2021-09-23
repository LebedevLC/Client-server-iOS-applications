//
//  RepostControl.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 14.09.2021.
//

import UIKit

final class RepostControl: UIControl {
    
    var controlTapped: (() -> Void)?
    
    private var repostButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private var repostLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var repostStatic: Bool?
    
//MARK:- LifeCicle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setView()
    }
    
//MARK:- Body
    
    private func setView() {
        self.addSubview(repostButton)
        self.addSubview(repostLabel)
        self.repostButton.addTarget(self, action: #selector(tapControl(_:)), for: .touchUpInside)
        let size: CGFloat = 30
        NSLayoutConstraint.activate ([
            repostButton.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            repostButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            repostButton.heightAnchor.constraint(equalToConstant: size),
            repostButton.widthAnchor.constraint(equalToConstant: size),
        ])
        NSLayoutConstraint.activate ([
            repostLabel.topAnchor.constraint(equalTo: repostButton.bottomAnchor, constant: 2),
            repostLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
            repostLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
            repostLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 2),
        ])
    }
    
//MARK:- TapButton
    
    enum repostState: String {
        case repostON =  "Рекомендуете"
        case repostOFF = "Рекомендовать"
    }

    private func repostON() {
        repostLabel.text = repostState.repostON.rawValue
        repostButton.tintColor = UIColor.lightGray
        repostButton.setBackgroundImage(UIImage(systemName: "hand.thumbsup.fill"), for: .normal)
        repostLabel.textColor = UIColor.gray
        repostStatic?.toggle()
    }
    
    private func repostOFF() {
        repostLabel.text = repostState.repostOFF.rawValue
        repostButton.tintColor = UIColor.link
        repostButton.setBackgroundImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
        repostLabel.textColor = UIColor.link
        repostStatic?.toggle()
    }
    
    func configure(isRepost: Bool) {
        repostStatic = isRepost
        if isRepost {
            repostOFF()
        } else {
            repostON()
        }
    }
    
    @objc func tapControl(_ sender: UIButton) {
        controlTapped?()
        animatedLabel()
    }
    
//MARK:- Animation
    
    private func animatedLabel() {
        UIView.transition(with: repostLabel,
                          duration: 0.2,
                          options: .transitionFlipFromTop,
                          animations: { [unowned self] in
                            switch repostStatic{
                            case true: repostOFF()
                            case false: repostON()
                            case .none:
                                return
                            case .some(_):
                                return
                            }
                          }
        )
    }
    
}
