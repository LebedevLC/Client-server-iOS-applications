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
    private let getSuggestionsUrlPath = "https://api.vk.com/method/friends.getSuggestions"
    private let realmService = RealmServices()
    
    enum Order: String {
        case hints = "hints"
        case name = "name"
        case random = "random"
        
    }
    
    // MARK: - Friends.get
    
    func getFriends(userId: Int, order: Order) {
        let paramters: Parameters = [
            "user_id": "\(userId)",
            // сортировать по Order
            "order": "\(order)",
            "fields": "nickname,bdate,city,photo_100,online",
            "access_token": "\(UserSession.shared.token)",
            "v": "\(UserSession.shared.version)"
        ]
        AF.request(getUrlPath, method: .get, parameters: paramters).responseJSON { [weak self] response in
            guard response.data != nil else {
                debugPrint("Response from server = nil")
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
                    completion: { })
            } catch {
                debugPrint("Decode ERROR")
            }
        }
    }
    
    // MARK: - Friends.get (NO REALM)
    
    func getFriendsNoRealm(userId: Int, order: Order, completion: @escaping (Result<[FriendsItems], SimpleServiceError>) -> Void) {
        let paramters: Parameters = [
            "user_id": "\(userId)",
            // сортировать по Order
            "order": "\(order)",
            "fields": "nickname,bdate,city,photo_100,online",
            "access_token": "\(UserSession.shared.token)",
            "v": "\(UserSession.shared.version)"
        ]
        AF.request(getUrlPath, method: .get, parameters: paramters).responseJSON { response in
            if let error = response.error {
                completion(.failure(.serverError))
                debugPrint(error)
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
                debugPrint("Decode ERROR")
                completion(.failure(.decodeError))
            }
        }
    }
    
    // MARK: - Friends.search
    
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
            "v": "\(UserSession.shared.version)"
        ]
        
        AF.request(searchUrlPath, method: .get, parameters: paramters).responseJSON { response in
            if let error = response.error {
                completion(.failure(.serverError))
                debugPrint(error)
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
                debugPrint("decode error")
                completion(.failure(.decodeError))
            }
        }
    }
    
    // MARK: - Friends.add
    
    func getAddFriend(userID: Int, completion: @escaping (Result<ResponseServerCodeModel, SimpleServiceError>) -> Void) {
        let paramters: Parameters = [
            "user_id": "\(userID)",
            "access_token": "\(UserSession.shared.token)",
            "v": "\(UserSession.shared.version)"
        ]
        AF.request(addUrlPath, method: .get, parameters: paramters).responseJSON { response in
            if let error = response.error {
                completion(.failure(.serverError))
                debugPrint(error)
            }
            guard response.data != nil else {
                completion(.failure(.notData))
                debugPrint(completion)
                return
            }
            do {
                let responseFriendAdd = try JSONDecoder().decode(ResponseServerCodeModel.self, from: response.data!)
                completion(.success(responseFriendAdd))
            } catch {
                debugPrint("decode error")
                completion(.failure(.decodeError))
                debugPrint("Ищу ошибку...")
                self.getAddFriendError(userID: userID, param: paramters) { result in
                    switch result {
                    case .success(let answer):
                        debugPrint(answer)
                    case .failure:
                        return
                    }
                }
                return
            }
        }
    }
    
    // MARK: - Поиск ошибки в запросе дружить
    
    private func getAddFriendError(userID: Int, param: Parameters,
                                   completion: @escaping (Result<ErrorAddFriendModel, SimpleServiceError>) -> Void) {
        AF.request(addUrlPath, method: .get, parameters: param).responseJSON { response in
            do {
                let responseFriendAddError = try JSONDecoder().decode(ErrorAddFriendModel.self, from: response.data!)
                completion(.success(responseFriendAddError))
            } catch {
                completion(.failure(.decodeError))
                debugPrint("Ошибка декодирования, неизвестные данные")
                return
            }
        }
    }

    // MARK: - Friends.delete

    func getDeleteFriend(userID: Int, completion: @escaping (Result<ResponseServerFriendDelete, SimpleServiceError>) -> Void) {
        let paramters: Parameters = [
            "user_id": "\(userID)",
            "access_token": "\(UserSession.shared.token)",
            "v": "\(UserSession.shared.version)"
        ]
        AF.request(deleteUrlPath, method: .get, parameters: paramters).responseJSON { response in
            if let error = response.error {
                completion(.failure(.serverError))
                debugPrint(error)
            }
            guard response.data != nil else {
                completion(.failure(.notData))
                debugPrint(completion)
                return
            }
            do {
                let responseDeleteFriend = try JSONDecoder().decode(ResponseServerFriendDelete.self, from: response.data!)
                completion(.success(responseDeleteFriend))
            } catch {
                debugPrint(response)
                debugPrint("decode error")
                completion(.failure(.decodeError))
            }
        }
    }
    
    // MARK: - Friends.getSuggestions
    
    func getSuggestionsFriends(completion: @escaping (Result<[UsersSearchItems], SimpleServiceError>) -> Void) {
        let paramters: Parameters = [
            "user_id": "\(UserSession.shared.userId)",
            "fields": "photo_100",
            "count": "100",
            "access_token": "\(UserSession.shared.token)",
            "v": "\(UserSession.shared.version)"
        ]
        
        AF.request(getSuggestionsUrlPath, method: .get, parameters: paramters).responseJSON { response in
            if let error = response.error {
                completion(.failure(.serverError))
                debugPrint(error)
            }
            guard response.data != nil else {
                completion(.failure(.notData))
                return
            }
            do {
                let responseFriends = try JSONDecoder().decode(UsersSearchModel.self, from: response.data!)
                let friends = responseFriends.response.items
                completion(.success(friends))
            } catch {
                debugPrint("decode error")
                completion(.failure(.decodeError))
            }
        }
    }
}
