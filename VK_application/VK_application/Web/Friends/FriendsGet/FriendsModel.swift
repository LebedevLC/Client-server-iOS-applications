//
//  FriendsModel.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 25.09.2021.
//

import Foundation
import RealmSwift

struct FriendsModel: Codable {
    let response: FriendsResponse
}

struct FriendsResponse: Codable {
    let count: Int
    let items: [FriendsItems]
}

class FriendsItems: Object, Codable {
    @objc dynamic var first_name: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var last_name: String = ""
    @objc dynamic var photo_100: String = ""
//  let bdate: String
//  let city: City
    
    enum CodingKeys: String, CodingKey {
        case first_name = "first_name"
        case id = "id"
        case last_name = "last_name"
        case photo_100 = "photo_100"
    }
}

struct City: Codable {
    let id: Int
    let title: String
}
