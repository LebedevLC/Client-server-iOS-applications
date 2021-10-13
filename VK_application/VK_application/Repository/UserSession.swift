//
//  Session.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 16.09.2021.
//

import Foundation

class UserSession {
    
    static let shared = UserSession()
    
    private init(){}
    
    var token: String = ""
    var userId: Int = 0
}

