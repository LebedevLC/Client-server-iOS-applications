//
//  WallGetModel.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 14.10.2021.
//

import Foundation

struct WallGetModel: Codable {
    let response: WallGetResponse
}

struct WallGetResponse: Codable {
    let count: Int
    let items: [WallGetItems]
}

struct WallGetItems: Codable {
    var id: Int = 0
    var from_id: Int = 0
    var owner_id: Int = 0
    var date: Date
    var post_type: String = ""
    var text: String = ""
    var copy_history: [CopyHistory]
    var comments: Comments
    var likes: Likes
    var reposts: Reposts
    var views: Views
}

struct CopyHistory: Codable {
    var id: Int = 0
    var owner_id: Int = 0
    var from_id: Int = 0
    var date: Date
    var post_type: String = ""
    var text: String = ""
    var attachments: [Attachments]
}

struct Attachments: Codable {
    var type: String = ""
    var photo: Photo
}

struct Photo: Codable {
    var album_id: Int = 0
    var date: Date
    var id: Int = 0
    var owner_id: Int = 0
    var access_key: String = ""
    var sizes: [Sizes]
    var text: String = ""
    var user_id: Int = 0
}

struct Sizes: Codable {
    var height: Int = 0
    var width: Int = 0
    var type: String = ""
    var url: String = ""
}

struct Comments: Codable {
    var can_post: Int = 0
    var can_close: Int = 0
    var count: Int = 0
    var groups_can_post: Bool
}

struct Likes: Codable {
    var can_like: Int = 0
    var count: Int = 0
    var user_likes: Int = 0
}

struct Reposts: Codable {
    var count: Int = 0
}

struct Views: Codable {
    var count: Int = 0
}
