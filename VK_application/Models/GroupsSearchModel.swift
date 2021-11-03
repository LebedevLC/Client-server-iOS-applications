//
//  GroupsSearchModel.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 30.09.2021.
//

import Foundation
import RealmSwift

struct GroupsSearchModel: Codable {
    let response: GroupsSearchResponse
}

struct GroupsSearchResponse: Codable {
    let count: Int
    let items: [GroupsSearchItems]
}

class GroupsSearchItems: Object, Codable {
   @objc dynamic var id: Int = 0
   @objc dynamic var name: String = ""
   @objc dynamic var screen_name: String = ""
   @objc dynamic var is_closed: Int = 0
   @objc dynamic var type: String = ""
   @objc dynamic var is_admin: Int = 0
   @objc dynamic var is_member: Int = 0
   @objc dynamic var is_advertiser: Int = 0
   @objc dynamic var photo_50: String = ""
   @objc dynamic var photo_100: String = ""
   @objc dynamic var photo_200: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case type = "type"
        case photo_100 = "photo_100"
        case screen_name = "screen_name"
        case is_closed = "is_closed"
        case is_admin = "is_admin"
        case is_member = "is_member"
        case is_advertiser = "is_advertiser"
    }
}
