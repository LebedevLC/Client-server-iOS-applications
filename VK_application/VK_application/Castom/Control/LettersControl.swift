//
//  LettersControl.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 19.07.2021.
//

import UIKit

final class LettersControl: UIControl {
    
    private var buttons = [UIButton]()
    private var stackView: UIStackView!
    private var letters = [String]() {
        didSet {
            setupStack()
        }
    }

    var selectLetter: String? = nil {
        didSet {
            self.sendActions(for: .valueChanged)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupUIView()
    }

    /// Установка букв для кнопок контрола
    func setLetters(_ letters: [String]) {
        self.letters = letters
    }

    /// Удаление кнопок
    func refreshButtons() {
        stackView.removeFromSuperview()
        buttons = []
        setupUIView()
    }
    
    // Настройка кнопок для UIStackView
    private func setupStack() {
        for letter in letters {
            let button = UIButton(type: .system)
            button.backgroundColor = .clear
            button.setTitle(letter, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.addTarget(self, action: #selector(selectedLetter(_:)), for: .touchUpInside)
            self.buttons.append(button)
        }
        stackView = UIStackView(arrangedSubviews: self.buttons)
        addSubview(stackView)
        stackView.spacing = 0
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.layer.cornerRadius = 7
    }

    // Выбранная кнопка сообщает свой индекс
    @objc private func selectedLetter(_ sender: UIButton) {
        guard let index = self.buttons.firstIndex(of: sender) else {
            return
        }
        self.selectLetter = letters[index]
    }
    
    // Установка внешнего вида контрола
    private func setupUIView() {
        stackView.frame = bounds
        stackView.layer.borderWidth = 1
        stackView.layer.backgroundColor = UIColor.white.cgColor
        stackView.alpha = 0.4
    }
}
