//
//  AttributedStringSetup.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 21.11.2021.
//

import Foundation
import UIKit

class AttributedStringSetup {
    func simpleStringSetup(text: String, size: Int, color: UIColor) -> NSAttributedString {
         let font = UIFont.systemFont(ofSize: CGFloat(size))
         let attributes = [NSAttributedString.Key.font: font,
                           NSAttributedString.Key.foregroundColor: color]
         let attributedText = NSAttributedString(string: text, attributes: attributes)
         return attributedText
     }
}
