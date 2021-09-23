//
//  NotificationControl.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 14.09.2021.
//

import UIKit

final class NotificationControl: UIControl {
    
    var controlTapped: (() -> Void)?
    
    private var notificationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private var notificationLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var notificationStatic: Bool?
    
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
        self.addSubview(notificationButton)
        self.addSubview(notificationLabel)
        self.notificationButton.addTarget(self, action: #selector(tapControl(_:)), for: .touchUpInside)
        let size: CGFloat = 30
        NSLayoutConstraint.activate ([
            notificationButton.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            notificationButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            notificationButton.heightAnchor.constraint(equalToConstant: size),
            notificationButton.widthAnchor.constraint(equalToConstant: size),
        ])
        NSLayoutConstraint.activate ([
            notificationLabel.topAnchor.constraint(equalTo: notificationButton.bottomAnchor, constant: 2),
            notificationLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
            notificationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
            notificationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 2),
        ])
    }
    
//MARK:- TapButton
    
    enum notificationState: String {
        case notificationON = "Уведомления"
        case notificationOFF = "Уведомлять"
    }

    private func notificationON() {
        notificationLabel.text = notificationState.notificationON.rawValue
        notificationButton.tintColor = UIColor.lightGray
        notificationButton.setBackgroundImage(UIImage(systemName: "bell.fill"), for: .normal)
        notificationLabel.textColor = UIColor.gray
        notificationStatic?.toggle()
    }
    
    private func notificationOFF() {
        notificationLabel.text = notificationState.notificationOFF.rawValue
        notificationButton.tintColor = UIColor.link
        notificationButton.setBackgroundImage(UIImage(systemName: "bell"), for: .normal)
        notificationLabel.textColor = UIColor.link
        notificationStatic?.toggle()
    }
    
    func configure(isNotification: Bool) {
        notificationStatic = isNotification
        if isNotification {
            notificationOFF()
        } else {
            notificationON()
        }
    }
    
    @objc func tapControl(_ sender: UIButton) {
        controlTapped?()
        animatedLabel()
    }
    
//MARK:- Animation
    
    private func animatedLabel() {
        UIView.transition(with: notificationLabel,
                          duration: 0.2,
                          options: .transitionFlipFromTop,
                          animations: { [unowned self] in
                            switch notificationStatic{
                            case true: notificationOFF()
                            case false: notificationON()
                            case .none:
                                return
                            case .some(_):
                                return
                            }
                          }
        )
    }
    
}
