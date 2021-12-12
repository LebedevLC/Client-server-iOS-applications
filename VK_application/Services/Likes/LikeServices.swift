//
//  LikeServices.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 24.11.2021.
//

import Foundation
import Alamofire

enum LikeType: String {
    case post = "post"
    case comment = "comment"
    case photo = "photo"
    case audio = "audio"
    case video = "video"
    case note = "note"
    case photoComment = "photo_comment"
    case videoComment = "video_comment"
    case topicComment = "topic_comment"
}

// MARK: - Добавить лайк для объекта

class LikeServices {
    private let likeUrlPath = "https://api.vk.com/method/likes.add"
    
    func getWall(itemId: Int, type: LikeType, accessKey: String, completion: @escaping (Result<[Likes], SimpleServiceError>) -> Void) {
        let paramters: Parameters = [
            "item_id": "\(itemId)",
            "type": type,
            "access_token": accessKey,
            "v": "\(UserSession.shared.version)"
        ]
        
        AF.request(likeUrlPath, method: .get, parameters: paramters).responseJSON { response in
            if let error = response.error {
                completion(.failure(.serverError))
                debugPrint("server Error!")
                debugPrint(error)
            }
            guard response.data != nil else {
                completion(.failure(.notData))
                debugPrint("Error - not Data!")
                return
            }
//            do {
//                let responseWall = try JSONDecoder().decode(Likes.self, from: response.data!)
//                let wall = responseWall.response.items
//                completion(.success(wall))
//            } catch {
//                completion(.failure(.decodeError))
//                debugPrint("Decode Error")
//            }
        }
    }
}
