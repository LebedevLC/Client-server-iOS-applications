//
//  AccountModel.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 14.10.2021.
//

import Foundation
import RealmSwift

struct AccountModel: Decodable {
    let response: AccountItems
}

class AccountItems: Object, Decodable {
    @objc dynamic var id: Int = 0
    @objc dynamic var first_name: String = ""
    @objc dynamic var last_name: String = ""
    @objc dynamic var home_town: String = ""
    @objc dynamic var status: String = ""
    @objc dynamic var phone: String = ""
    @objc dynamic var screen_name: String = ""
    @objc dynamic var sex: Int = 2
    
    enum CodingKeys: String, CodingKey {
        case id
        case first_name
        case last_name
        case home_town
        case status
        case phone
        case screen_name
        case sex
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.first_name = try values.decode(String.self, forKey: .first_name)
        self.last_name = try values.decode(String.self, forKey: .last_name)
        self.home_town = try values.decode(String.self, forKey: .home_town)
        self.status = try values.decode(String.self, forKey: .status)
        self.phone = try values.decode(String.self, forKey: .phone)
        self.screen_name = try values.decode(String.self, forKey: .screen_name)
        self.sex = try values.decode(Int.self, forKey: .sex)
    }

}
