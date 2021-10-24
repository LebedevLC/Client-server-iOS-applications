//
//  DefaultAlert.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 20.10.2021.
//

import UIKit

class DefaultAlert: NSObject {
    
static let alert = DefaultAlert()

    //Show alert
    func okAlert(view: UIViewController, title: String, message: String, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { action in
            DispatchQueue.main.async {
                completion()
            }
        })
        alert.addAction(defaultAction)
        DispatchQueue.main.async(execute: {
            view.present(alert, animated: true)
        })
    }

    private override init() {
    }
}
