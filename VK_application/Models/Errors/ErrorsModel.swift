//
//  ErrorsModel.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 13.10.2021.
//

import Foundation
import RealmSwift

//MARK: - Some Error

// Service Error
enum SimpleServiceError: Error {
    case serverError
    case notData
    case decodeError
}

//MARK: - Friend

// addFriend
struct ErrorAddFriendModel: Codable {
    let error: ErrorAddFriendResponse
}

struct ErrorAddFriendResponse: Codable {
    let error_code: Int
    let error_msg: String
}



