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

class UsersSearch {
    /*
     Примерный запрос
     https://api.vk.com/method/users.search?q=вася&user_id=&fields=photo_100&count=100&access_token=TOKEN&v=5.81
     */
    
    // Адресс запроса
   private let urlPath = "https://api.vk.com/method/users.search"
    
    /// q = поисковый запрос, count = колличество получаемых друзей ( максимально 1000 )
    func getSearchUsers(q: String, count: Int, completion: @escaping (Result<[UsersSearchItems], FriendsServiceError>) -> Void) {
        var c: Int = 20
        if count <= 1000 {
            c = count
        }
        // Параметры запроса
        let paramters: Parameters = [
            "user_id": "\(UserSession.shared.userId)",
            "q": "\(q)",
            "fields": "photo_100",
            "count": "\(c)",
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
                let responseUsers = try JSONDecoder().decode(UsersSearchModel.self, from: response.data!)
                let users = responseUsers.response.items
                completion(.success(users))
//                self.saveUsersData(users)
            } catch {
                completion(.failure(.decodeError))
            }
        }
    }
    
    // Запись данных в Realm
    func saveUsersData(_ users: [UsersSearchItems]) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            print("начинаю запись данных в Realm")
            realm.add(users)
            print("добавляю запись")
            try realm.commitWrite()
            print("добавил \(users.count) записей")
            print("заканчиваю запись и сохраняю изменения")
        } catch {
            print(error)
        }
    }
}
