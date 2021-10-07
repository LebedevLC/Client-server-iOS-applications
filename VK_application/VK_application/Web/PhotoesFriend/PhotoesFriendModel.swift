//
//  PhotoesFriendModel.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 26.09.2021.
//

//import Foundation
//import RealmSwift
//
//struct Photoes: Codable {
//    let response: PhotoesResponse
//}
//
//struct PhotoesResponse: Codable {
//    let count: Int
//    let items: [PhotoesItems]
//}
//
//class PhotoesItems: Object, Codable {
//    @objc dynamic var album_id: Int = 0
//    @objc dynamic var id: Int = 0
//    @objc dynamic var sizes: [PhotoesSizes]
//    @objc dynamic var text: String = ""
//    @objc dynamic var likes: PhotoLikes
//    @objc dynamic var reposts: PhotoRepost
//}
//
//class PhotoesSizes: Object, Codable {
//    @objc dynamic var url: String = ""
//    @objc dynamic var type: String = ""
//    @objc dynamic var height: Int = 0
//    @objc dynamic var width: Int = 0
//}
//
//class PhotoLikes: Object, Codable {
//    @objc dynamic var user_likes: Int = 0
//    @objc dynamic var count: Int = 0
//}
//
//class PhotoRepost: Object, Codable {
//    @objc dynamic var count: Int = 0
//}


import Foundation
import RealmSwift

struct Photoes: Decodable {
    let response: PhotoesResponse
}

struct PhotoesResponse: Decodable {
    let count: Int
    let items: [PhotoesItems]
}

class PhotoesItems: Object, Decodable {
    @objc dynamic var album_id: Int = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var text: String = ""
    @objc dynamic var user_likes: Int = 0
    @objc dynamic var repostCount: Int = 0
    @objc dynamic var likesCount: Int = 0
    var sizesArray = [String]()
    
    
    enum CodingKeys: String, CodingKey { // обычные объекты
        case sizes
        case likes
        case reposts
        case album_id
        case id
        case text
    }
    
    enum SizesKeys: String, CodingKey {  // это должен быть массив объектов
        case url
        case type
    }
    
    enum PhotoLikesKeys: String, CodingKey { // вложенные объекты
        case user_likes
        case likesCount = "count"
    }
    
    enum PhotoRepostKeys: String, CodingKey { // вложенные объекты
        case repostCount = "count"
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.album_id = try values.decode(Int.self, forKey: .album_id)
        self.id = try values.decode(Int.self, forKey: .id)
        self.text = try values.decode(String.self, forKey: .text)
        
        // чтобы получить вложенный массив от объекта для данного ключа
        var sizesContainer = try values.nestedUnkeyedContainer(forKey: .sizes) // ok
        
        while !sizesContainer.isAtEnd {
            // чтобы получить следующий вложенный массив из массива
            let sizesValue = try sizesContainer.nestedContainer(keyedBy: SizesKeys.self)
            sizesArray.append(try sizesValue.decode(String.self, forKey: .url))
            sizesArray.append(try sizesValue.decode(String.self, forKey: .type) + "+")
        }
        
        // чтобы получить вложенный объект из объекта для данного ключа
        let likesContainer = try values.nestedContainer(keyedBy: PhotoLikesKeys.self, forKey: .likes)
        self.user_likes = try likesContainer.decode(Int.self, forKey: .user_likes)
        self.likesCount = try likesContainer.decode(Int.self, forKey: .likesCount)
        
        let repostContainer = try values.nestedContainer(keyedBy: PhotoRepostKeys.self, forKey: .reposts)
        self.repostCount = try repostContainer.decode(Int.self, forKey: .repostCount)
    }
}
