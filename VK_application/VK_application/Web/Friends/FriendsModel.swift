//
//  FriendsModel.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 25.09.2021.
//

import Foundation

struct Friends: Codable {
    let response: FriendsResponse
}

struct FriendsResponse: Codable {
    let count: Int
    let items: [FriendsItems]
}

struct FriendsItems: Codable {
    let first_name: String
    let id: Int
    let last_name: String
    let photo_100: URL
//            let bdate: String
//            let city: City
}

struct City: Codable {
    let id: Int
    let title: String
}
