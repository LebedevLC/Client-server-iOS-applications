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
    let items: [WallItems]
}

struct WallItems: Codable {
    var id: Int
    var date: Int
    var post_type: String
    var text: String
    var attachments: [Attachments]?
    var comments: Comments?
    var likes: Likes?
    var reposts: Reposts?
    var views: Views?
}

struct Attachments: Codable {
    var type: String
    var photo: Photo?
}

struct Photo: Codable {
    var album_id: Int
//    var date: Date
    var id: Int
    var owner_id: Int
    var access_key: String
    var sizes: [Sizes]
    var text: String
    var user_id: Int
}

struct Sizes: Codable {
    var height: Int
    var width: Int
    var type: String
    var url: String
}

struct Comments: Codable {
    var can_post: Int
    var count: Int
}

struct Likes: Codable {
    var can_like: Int
    var count: Int
    var user_likes: Int
}

struct Reposts: Codable {
    var count: Int
    var user_reposted: Int
}

struct Views: Codable {
    var count: Int
}
