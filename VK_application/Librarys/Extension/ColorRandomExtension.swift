//
//  ColorRandomExtension.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 16.07.2021.
//
import UIKit

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    /// Даёт рандомный цвет UIColor, alpha = 0.9
    static func random() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 0.9)
    }
}
