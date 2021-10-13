//
//  PhotoesFriendModel.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 26.09.2021.
//

import Foundation
import RealmSwift

struct PhotoesModel: Decodable {
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
    @objc dynamic var singleSizePhoto: String = ""
    var sizesArray = List<String>()
    
    var ownerId = RealmOptional<Int>()
    
    // обычные объекты
    enum CodingKeys: String, CodingKey {
        case sizes
        case likes
        case reposts
        case album_id
        case id
        case text
    }
    
    // массив объектов
    enum SizesKeys: String, CodingKey {
        case url
        case type
    }
    
    // вложенные объекты
    enum PhotoLikesKeys: String, CodingKey {
        case user_likes
        case likesCount = "count"
    }
    
    // вложенные объекты
    enum PhotoRepostKeys: String, CodingKey {
        case repostCount = "count"
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.album_id = try values.decode(Int.self, forKey: .album_id)
        self.id = try values.decode(Int.self, forKey: .id)
        self.text = try values.decode(String.self, forKey: .text)
        
        // получить вложенный массив от объекта для данного ключа
        var sizesContainer = try values.nestedUnkeyedContainer(forKey: .sizes)
        while !sizesContainer.isAtEnd {
            // получить следующий вложенный массив из массива
            let sizesValue = try sizesContainer.nestedContainer(keyedBy: SizesKeys.self)
            sizesArray.append(try sizesValue.decode(String.self, forKey: .url))
            sizesArray.append(try sizesValue.decode(String.self, forKey: .type))
        }
        // получаем фото лучшего качества
        singleSizePhoto = sizesArray[sizesArray.endIndex-2]
        
        // получить вложенный объект из объекта для данного ключа
        let likesContainer = try values.nestedContainer(keyedBy: PhotoLikesKeys.self, forKey: .likes)
        self.user_likes = try likesContainer.decode(Int.self, forKey: .user_likes)
        self.likesCount = try likesContainer.decode(Int.self, forKey: .likesCount)
        
        let repostContainer = try values.nestedContainer(keyedBy: PhotoRepostKeys.self, forKey: .reposts)
        self.repostCount = try repostContainer.decode(Int.self, forKey: .repostCount)
    }
}
