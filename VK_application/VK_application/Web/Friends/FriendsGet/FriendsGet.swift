//
//  FriendsGet.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 22.09.2021.
//

import Alamofire
import Foundation
import RealmSwift

enum FriendsServiceError: Error {
    case decodeError
    case notData
    case serverError
}

class FriendsGet {
     
    /*
     METHOD - friends.get
     Cтандартный запрос к API:
     https://api.vk.com/method/METHOD?PARAMS&access_token=TOKEN&v=V
     
     Примерный запрос
     https://api.vk.com/method/friends.get?fields=nickname,bdate,city,photo_50&count=1&access_token=TOKEN&v=5.81
    
     fields - поля для получения:
           nickname, domain, sex, bdate, city, country, timezone, photo_50, photo_100, photo_200_orig,
           has_mobile, contacts, education, online, relation, last_seen, status, can_write_private_message,
           can_see_all_posts, can_post, universities
     count - колличество отображаемых друзей
     */
    
    // Адресс запроса
    private let urlPath = "https://api.vk.com/method/friends.get"
    
    func getFriends(completion: @escaping (Result<[FriendsItems], FriendsServiceError>) -> Void) {

        // Параметры запроса
        let paramters: Parameters = [
            "fields": "nickname,bdate,city,photo_100",
//            "count": "10",
            // токен доступа
            "access_token": "\(UserSession.shared.token)",
            // версия API
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
                let responseFriends = try JSONDecoder().decode(FriendsModel.self, from: response.data!)
                let friends = responseFriends.response.items
                completion(.success(friends))
                self.saveFriendsData(friends)
            } catch {
                completion(.failure(.decodeError))
            }
        }
    }
    
    // Запись данных в Realm
    func saveFriendsData(_ friends: [FriendsItems]) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            print("начинаю запись данных в Realm")
            realm.add(friends)
            print("добавляю запись")
            try realm.commitWrite()
            print("добавил \(friends.count) записей")
            print("заканчиваю запись и сохраняю изменения")
            print(realm.configuration.fileURL)
        } catch {
            print(error)
        }
    }
    
}

