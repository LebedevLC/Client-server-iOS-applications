//
//  NewsFeedModel.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 26.10.2021.
//

import Foundation

struct NewsFeedModel: Codable {
    let response: NewsFeedResponse
}

struct NewsFeedResponse: Codable {
    var items: [NewsFeedItems]
    var profiles: [NewsFeedProfile]?
    var groups: [NewsFeedGroup]?
    var next_from: String?
}

struct NewsFeedItems: Codable {
    var source_id: Int?
    var date: Double?
    var post_type: String?
    var text: String?
    var post_id: Int?
    var attachments: [Attachments]?
    var comments: Comments?
    var likes: Likes?
    var reposts: Reposts?
    var views: Views?
}

struct NewsFeedProfile: Codable {
    var first_name: String?
    var id: Int?
    var last_name: String?
    var photo_50: String?
    var photo_100: String?
}

struct NewsFeedGroup: Codable {
    var id: Int?
    var name: String?
    var screen_name: String?
    var photo_50: String?
    var photo_100: String?
    var photo_200: String?
}
