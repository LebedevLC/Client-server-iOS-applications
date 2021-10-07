//
//  UserSearchModel.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 01.10.2021.
//

import Foundation
import RealmSwift

struct UsersSearchModel: Codable {
    let response: UsersSearchResponse
}

struct UsersSearchResponse: Codable {
    let count: Int
    let items: [UsersSearchItems]
}

class UsersSearchItems: Object, Codable {
    @objc dynamic var first_name: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var last_name: String = ""
    @objc dynamic var photo_100: String = ""
    
    enum CodingKeys: String, CodingKey {
        case first_name = "first_name"
        case id = "id"
        case last_name = "last_name"
        case photo_100 = "photo_100"
    }
}
