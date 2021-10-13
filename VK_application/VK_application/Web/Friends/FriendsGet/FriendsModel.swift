//
//  FriendsModel.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 25.09.2021.
//

import Foundation
import RealmSwift

struct FriendsModel: Decodable {
    let response: FriendsResponse
}

struct FriendsResponse: Decodable {
    let count: Int
    let items: [FriendsItems]
}

class FriendsItems: Object, Decodable {
    @objc dynamic var myOwnerId: Int = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var first_name: String = ""
    @objc dynamic var last_name: String = ""
    @objc dynamic var photo_100: String = ""
    
//    override class func primaryKey() -> String? {
//        return "id"
//    }
    
    enum CodingKeys: String, CodingKey { // обычные объекты
        case id
        case first_name
        case last_name
        case photo_100
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.first_name = try values.decode(String.self, forKey: .first_name)
        self.last_name = try values.decode(String.self, forKey: .last_name)
        self.photo_100 = try values.decode(String.self, forKey: .photo_100)
        self.myOwnerId = myOwnerId
    }

}

