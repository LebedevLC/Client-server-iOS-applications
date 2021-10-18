//
//  FriendsGet.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 22.09.2021.
//

import Foundation
import Alamofire
import RealmSwift

class FriendsServices {
    
    private let getUrlPath = "https://api.vk.com/method/friends.get"
    private let searchUrlPath = "https://api.vk.com/method/friends.search"
    private let addUrlPath = "https://api.vk.com/method/friends.add"
    private let deleteUrlPath = "https://api.vk.com/method/friends.delete"
    private let realmService = RealmServices()
    
    enum Order: String {
        case hints = "hints"
        case name = "name"
        case random = "random"
        
    }
    
    //MARK: - Friends.get
    
//    func getFriends(userId: Int, completion: @escaping () -> Void) {
    func getFriends(userId: Int, order: Order) {
        let paramters: Parameters = [
            // сортировать по Order
            "order": "\(order)",
            "fields": "nickname,bdate,city,photo_100,online",
            "access_token": "\(UserSession.shared.token)",
            "v": "\(UserSession.shared.v)"
        ]
        AF.request(getUrlPath, method: .get, parameters: paramters).responseJSON { [weak self] response in
            guard response.data != nil else {
                print("Response from server = nil")
                return
            }
            do {
                let responseFriends = try JSONDecoder().decode(FriendsModel.self, from: response.data!)
                let friends = responseFriends.response.items
                // RealmService
                friends.forEach{ $0.myOwnerId = UserSession.shared.userId}
                self?.realmService.saveData(
                    filter: "myOwnerId",
                    filterText: UserSession.shared.userId,
                    array: friends,
                    completion: {} )
            } catch {
                print("Decode ERROR")
            }
        }
    }
    
    //MARK: - Friends.search
    
    /// q = поисковый запрос, count = колличество получаемых друзей ( максимально 1000 )
    func getSearchFriends(q: String, count: Int, completion: @escaping (Result<[FriendsItems], SimpleServiceError>) -> Void) {
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
                let responseFriends = try JSONDecoder().decode(FriendsModel.self, from: response.data!)
                let friends = responseFriends.response.items
                completion(.success(friends))
            } catch {
                completion(.failure(.decodeError))
            }
        }
    }
    
    //MARK: - Friends.add
    
    func getAddFriend(userID: Int, completion: @escaping (Result<ResponseServerCodeModel, SimpleServiceError>) -> Void) {
        let paramters: Parameters = [
            "user_id": "\(userID)",
            "access_token": "\(UserSession.shared.token)",
            "v": "\(UserSession.shared.v)"
        ]
        AF.request(addUrlPath, method: .get, parameters: paramters).responseJSON { response in
            if let error = response.error {
                completion(.failure(.serverError))
                print(error)
            }
            guard response.data != nil else {
                completion(.failure(.notData))
                print(completion)
                return
            }
            do {
                let responseFriendAdd = try JSONDecoder().decode(ResponseServerCodeModel.self, from: response.data!)
                completion(.success(responseFriendAdd))
            } catch {
                completion(.failure(.decodeError))
                // раскодируем ошибку
                print("Ищу ошибку...")
                self.getAddFriendError(userID: userID, param: paramters) { result in
                    switch result {
                    case .success(let answer):
                        print(answer)
                    case .failure:
                        return
                    }
                }
                return
            }
        }
    }
    
    //MARK: - Поиск ошибки в запросе дружить
    
    private func getAddFriendError(userID: Int, param: Parameters,
                                   completion: @escaping (Result<ErrorAddFriendModel, SimpleServiceError>) -> Void) {
        AF.request(addUrlPath, method: .get, parameters: param).responseJSON { response in
            do {
                let responseFriendAddError = try JSONDecoder().decode(ErrorAddFriendModel.self, from: response.data!)
                completion(.success(responseFriendAddError))
            } catch {
                completion(.failure(.decodeError))
                print("Ошибка декодирования, неизвестные данные")
                return
            }
        }
    }

//MARK: - Friends.delete

func getDeleteFriend(userID: Int, completion: @escaping (Result<ResponseServerFriendDelete, SimpleServiceError>) -> Void) {
    let paramters: Parameters = [
        "user_id": "\(userID)",
        "access_token": "\(UserSession.shared.token)",
        "v": "\(UserSession.shared.v)"
    ]
    AF.request(deleteUrlPath, method: .get, parameters: paramters).responseJSON { response in
        if let error = response.error {
            completion(.failure(.serverError))
            print(error)
        }
        guard response.data != nil else {
            completion(.failure(.notData))
            print(completion)
            return
        }
        do {
            let responseDeleteFriend = try JSONDecoder().decode(ResponseServerFriendDelete.self, from: response.data!)
            completion(.success(responseDeleteFriend))
        } catch {
            print(response)
            print("decode error")
            completion(.failure(.decodeError))
        }
    }
}
}
