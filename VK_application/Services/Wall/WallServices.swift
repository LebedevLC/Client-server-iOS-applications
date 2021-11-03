//
//  NewsServices.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 14.10.2021.
//

import Foundation
import Alamofire
import RealmSwift

// MARK: - Получение списка записей со стены

class WallServices {
    private let feedUrlPath = "https://api.vk.com/method/wall.get"
    private let realmService = RealmServices()
    
    func getWall(ownerID: Int, count: Int, completion: @escaping (Result<[WallItems], SimpleServiceError>) -> Void) {
        let paramters: Parameters = [
            "owner_id": "\(ownerID)",
            "count": "\(count)",
            "access_token": "\(UserSession.shared.token)",
            "v": "\(UserSession.shared.version)"
        ]
        
        AF.request(feedUrlPath, method: .get, parameters: paramters).responseJSON { response in
            if let error = response.error {
                completion(.failure(.serverError))
                print("server Error!")
                print(error)
            }
            guard response.data != nil else {
                completion(.failure(.notData))
                print("Error - not Data!")
                return
            }
            do {
                let responseWall = try JSONDecoder().decode(WallGetModel.self, from: response.data!)
                let wall = responseWall.response.items
                completion(.success(wall))
            } catch {
                completion(.failure(.decodeError))
                print("Decode Error")
            }
        }
    }
}
