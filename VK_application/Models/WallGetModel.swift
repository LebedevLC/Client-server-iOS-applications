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
    let id: Int
    let date: Int
    let post_type: String
    let text: String
    let attachments: [Attachments]?
    let comments: Comments?
    let likes: Likes?
    let reposts: Reposts?
    let views: Views?
}

struct Attachments: Codable {
    var type: String?
    var photo: Photo?
}

struct Photo: Codable {
    let album_id: Int?
    let date: Int?
    let id: Int?
    let owner_id: Int?
    let access_key: String?
    let sizes: [Sizes]?
    let text: String?
    let user_id: Int?
}

struct Sizes: Codable {
    let height: Int?
    let width: Int?
    let type: String?
    let url: String?
}

struct Comments: Codable {
    let can_post: Int?
    let count: Int?
}

struct Likes: Codable {
    let can_like: Int?
    let count: Int?
    let user_likes: Int?
}

struct Reposts: Codable {
    let count: Int?
    let user_reposted: Int?
}

struct Views: Codable {
    let count: Int?
}
