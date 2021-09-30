//
//  PhotoesFriendModel.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 26.09.2021.
//

import Foundation

struct Photoes: Codable {
    let response: PhotoesResponse
}

struct PhotoesResponse: Codable {
    let count: Int
    let items: [PhotoesItems]
}

struct PhotoesItems: Codable {
    let album_id: Int
    let id: Int
    let sizes: [PhotoesSizes]
    let text: String
    let likes: PhotoLikes
    let reposts: PhotoRepost
}

struct PhotoesSizes: Codable {
    let url: URL
    let type: String
    let height: Int
    let width: Int
}

struct PhotoLikes: Codable {
    let user_likes: Int
    let count: Int
}

struct PhotoRepost: Codable {
    let count: Int
}
