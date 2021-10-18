//
//  GroupsGetModel.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 27.09.2021.
//

import Foundation
import RealmSwift


struct GroupsModel: Decodable {
    let response: GroupsResponse
}

struct GroupsResponse: Decodable {
    let count: Int
    let items: [GroupsItems]
}

class GroupsItems: Object, Decodable {
    @objc dynamic var ownerId: Int = 0
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
    @objc dynamic var descriptionGroup: String = ""
    @objc dynamic var members_count: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case descriptionGroup = "description"
        case id
        case name
        case type
        case photo_100
        case members_count
        case screen_name
        case is_closed
        case is_admin
        case is_member
        case is_advertiser
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.name = try values.decode(String.self, forKey: .name)
        self.type = try values.decode(String.self, forKey: .type)
        self.photo_100 = try values.decode(String.self, forKey: .photo_100)
        self.members_count = try values.decode(Int.self, forKey: .members_count)
        self.screen_name = try values.decode(String.self, forKey: .screen_name)
        self.is_closed = try values.decode(Int.self, forKey: .is_closed)
        self.is_admin = try values.decode(Int.self, forKey: .is_admin)
        self.is_member = try values.decode(Int.self, forKey: .is_member)
        self.is_advertiser = try values.decode(Int.self, forKey: .is_advertiser)
        self.descriptionGroup = try values.decode(String.self, forKey: .descriptionGroup)
        self.ownerId = ownerId
    }
}
