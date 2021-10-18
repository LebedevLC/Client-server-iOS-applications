//
//  UsersSearch.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 01.10.2021.
//

import Foundation
import Alamofire
import RealmSwift

//MARK: - Поиск по ВСЕМ ПОЛЬЗОВАТЕЛЯМ

class UsersServices {
    
    private let searchUrlPath = "https://api.vk.com/method/users.search"
    private let realmService = RealmServices()
    
    /// q = поисковый запрос, count = колличество получаемых друзей ( максимально 1000 )
    func getSearchUsers(q: String, count: Int, completion: @escaping (Result<[UsersSearchItems], SimpleServiceError>) -> Void) {
        var c: Int = 20
        if count <= 1000 {
            c = count
        }
        let paramters: Parameters = [
            "user_id": "\(UserSession.shared.userId)",
            "q": "\(q)",
            "fields": "photo_100",
            "count": "\(c)",
            "access_token": "\(UserSession.shared.token)",
            "v": "\(UserSession.shared.v)"
        ]
        
        AF.request(searchUrlPath, method: .get, parameters: paramters).responseJSON { response in
            if let error = response.error {
                completion(.failure(.serverError))
                print(error)
            }
            guard response.data != nil else {
                completion(.failure(.notData))
                return
            }
            do {
                let responseUsers = try JSONDecoder().decode(UsersSearchModel.self, from: response.data!)
                let users = responseUsers.response.items
                completion(.success(users))
                self.realmService.saveData(array: users)
            } catch {
                completion(.failure(.decodeError))
            }
        }
    }
}
