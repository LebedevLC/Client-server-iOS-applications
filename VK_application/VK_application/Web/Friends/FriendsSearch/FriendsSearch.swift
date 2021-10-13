//
//  FriendsSearch.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 01.10.2021.
//

import Foundation
import Alamofire

//MARK: - Поиск по ДРУЗЬЯМ

class FriendsSearchGet {
    
   private let urlPath = "https://api.vk.com/method/friends.search"
    
    /// q = поисковый запрос, count = колличество получаемых друзей ( максимально 1000 )
    func getSearchFriends(q: String, count: Int, completion: @escaping (Result<[FriendsSearchItems], FriendsServiceError>) -> Void) {
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
            "v": "5.81"
        ]
        
        AF.request(urlPath, method: .get, parameters: paramters).responseJSON { response in
            if let error = response.error {
                completion(.failure(.serverError))
                print(error)
            }
            guard response.data != nil else {
                completion(.failure(.notData))
                return
            }
            do {
                let responseFriends = try JSONDecoder().decode(FriendsSearchModel.self, from: response.data!)
                let friends = responseFriends.response.items
                completion(.success(friends))
            } catch {
                completion(.failure(.decodeError))
            }
        }
    }
}


