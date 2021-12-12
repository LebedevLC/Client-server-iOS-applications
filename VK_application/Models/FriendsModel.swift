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

class FriendsDataRealm: Object {
    @objc dynamic var id: Int = 0
    var friends = List<FriendsItems>()
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

class FriendsItems: Object, Decodable {
    @objc dynamic var myOwnerId: Int = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var online: Int = 0
    @objc dynamic var first_name: String = ""
    @objc dynamic var last_name: String = ""
    @objc dynamic var photo_100: String = ""
    @objc dynamic var title: String? = nil
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case online
        case first_name
        case last_name
        case photo_100
        case city = "city"
    }
    
    enum FriendsCityKeys: String, CodingKey {
        case title
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.online = try values.decode(Int.self, forKey: .online)
        self.first_name = try values.decode(String.self, forKey: .first_name)
        self.last_name = try values.decode(String.self, forKey: .last_name)
        self.photo_100 = try values.decode(String.self, forKey: .photo_100)
        
        do {
            let cityContainer = try values.nestedContainer(keyedBy: FriendsCityKeys.self, forKey: .city)
            self.title = try cityContainer.decode(String.self, forKey: .title)
        } catch {
            self.title = nil
        }
        
        self.myOwnerId = myOwnerId
    }

}

// MARK: - Friend delete response

struct ResponseServerFriendDelete: Decodable {
    let response: FriendDeleteResponse
}

struct FriendDeleteResponse: Decodable {
    let success: Int
}
