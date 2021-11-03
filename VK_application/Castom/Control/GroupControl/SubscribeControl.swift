//
//  SubscribeControl.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 12.09.2021.
//

import UIKit

final class SubscribeControl: UIControl {
    
    var controlTapped: (() -> Void)?
    
    private var subscribeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private var subscribeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var subState: Bool?
    
// MARK: - LifeCicle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setView()
    }
    
// MARK: - Body
    
    private func setView() {
        self.addSubview(subscribeButton)
        self.addSubview(subscribeLabel)
        self.subscribeButton.addTarget(self, action: #selector(tapControl(_:)), for: .touchUpInside)
        let size: CGFloat = 30
        NSLayoutConstraint.activate([
            subscribeButton.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            subscribeButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            subscribeButton.heightAnchor.constraint(equalToConstant: size),
            subscribeButton.widthAnchor.constraint(equalToConstant: size)
        ])
        NSLayoutConstraint.activate([
            subscribeLabel.topAnchor.constraint(equalTo: subscribeButton.bottomAnchor, constant: 2),
            subscribeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
            subscribeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
            subscribeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 2)
        ])
    }
    
// MARK: - TapButton
    
    enum SubscribeState: String {
        case subscribeON = "Вы подписаны"
        case subscribeOFF = "Подписаться"
    }

    private func subscribeON() {
        subscribeLabel.text = SubscribeState.subscribeON.rawValue
        subscribeButton.tintColor = UIColor.lightGray
        subscribeButton.setBackgroundImage(UIImage(systemName: "checkmark.rectangle.portrait.fill"), for: .normal)
        subscribeLabel.textColor = UIColor.gray
        subState?.toggle()
    }
    
    private func subscribeOFF() {
        subscribeLabel.text = SubscribeState.subscribeOFF.rawValue
        subscribeButton.tintColor = UIColor.link
        subscribeButton.setBackgroundImage(UIImage(systemName: "checkmark.rectangle.portrait"), for: .normal)
        subscribeLabel.textColor = UIColor.link
        subState?.toggle()
    }
    
    func configure(isSubscribe: Bool) {
        subState = isSubscribe
        if isSubscribe {
            subscribeOFF()
        } else {
            subscribeON()
        }
    }
    
    @objc func tapControl(_ sender: UIButton) {
        controlTapped?()
        animatedLabel()
    }
    
// MARK: - Animation
    
    private func animatedLabel() {
        UIView.transition(with: subscribeLabel,
                          duration: 0.2,
                          options: .transitionFlipFromTop,
                          animations: { [unowned self] in
                            switch subState {
                            case true: subscribeOFF()
                            case false: subscribeON()
                            case .none:
                                return
                            case .some(_):
                                break
                            }
                          }
        )
    }
    
}
