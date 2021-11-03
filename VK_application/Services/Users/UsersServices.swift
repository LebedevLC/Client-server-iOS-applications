//
//  UsersSearch.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 01.10.2021.
//

import Foundation
import Alamofire
import RealmSwift

// MARK: - Поиск по ВСЕМ ПОЛЬЗОВАТЕЛЯМ

class UsersServices {
    
    private let searchUsersUrlPath = "https://api.vk.com/method/users.search"
    private let usersInfoUrlPath = "https://api.vk.com/method/users.get"
    private let usersInfoFields = "photo_id, verified, sex, bdate, city, country, home_town, has_photo, photo_50, photo_100, photo_200_orig, photo_200, photo_400_orig, photo_max, photo_max_orig, online, domain, has_mobile, contacts, site, education, universities, schools, status, last_seen, followers_count, common_count, occupation, nickname, relatives, relation, personal, connections, exports, activities, interests, music, movies, tv, books, games, about, quotes, can_post, can_see_all_posts, can_see_audio, can_write_private_message, can_send_friend_request, is_favorite, is_hidden_from_feed, timezone, screen_name, maiden_name, crop_photo, is_friend, friend_status, career, military, blacklisted, blacklisted_by_me, can_be_invited_group"
    
    private let realmService = RealmServices()
    
    // MARK: - getSearchUsers
    
    /// Поиск пользователей.
    /// q = поисковый запрос, count = колличество получаемых друзей ( максимально 1000 )
    func getSearchUsers(q: String, count: Int, completion: @escaping (Result<[UsersSearchItems], SimpleServiceError>) -> Void) {
        var c: Int = 20
        if count <= 1000 {
            c = count
        }
        let parameters: Parameters = [
            "user_id": "\(UserSession.shared.userId)",
            "q": "\(q)",
            "fields": "photo_100",
            "count": "\(c)",
            "access_token": "\(UserSession.shared.token)",
            "v": "\(UserSession.shared.version)"
        ]
        
        AF.request(searchUsersUrlPath, method: .get, parameters: parameters).responseJSON { response in
            if let error = response.error {
                completion(.failure(.serverError))
                print("Server ERROR")
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
                print("Decode ERROR")
                completion(.failure(.decodeError))
            }
        }
    }
    
    // MARK: - getUsersInfo
    
    /// Возвращает расширенную информацию о пользователях.
    /// userId: идентификатор пользователя
    func getUsersInfo(userId: Int, completion: @escaping (Result<[UsersGetItems], SimpleServiceError>) -> Void) {
        let parameters: Parameters = [
            "user_ids": "\(userId)",
            "fields": usersInfoFields,
            "access_token": "\(UserSession.shared.token)",
            "v": "\(UserSession.shared.version)"
        ]
        AF.request(usersInfoUrlPath, method: .get, parameters: parameters).responseJSON { response in
            if let error = response.error {
                completion(.failure(.serverError))
                print("Server ERROR")
                print(error)
            }
            guard response.data != nil else {
                completion(.failure(.notData))
                return
            }
            do {
                let responseUsersInfo = try JSONDecoder().decode(UsersGetModel.self, from: response.data!)
                let usersInfo = responseUsersInfo.response
                completion(.success(usersInfo))
            } catch {
                print("------------Decode ERROR-------------")
                print(response)
                completion(.failure(.decodeError))
            }
        }
    }
}
