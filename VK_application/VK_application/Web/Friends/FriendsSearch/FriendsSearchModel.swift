//
//  FriendSearchModel.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 01.10.2021.
//

import Foundation

struct FriendsSearchModel: Codable {
    let response: FriendsSearchResponse
}

struct FriendsSearchResponse: Codable {
    let count: Int
    let items: [FriendsSearchItems]
}

struct FriendsSearchItems: Codable {
    let first_name: String
    let id: Int
    let last_name: String
    let photo_100: URL
}

