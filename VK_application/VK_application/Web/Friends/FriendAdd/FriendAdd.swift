//
//  FriendAdd.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 04.10.2021.
//

import Alamofire
import Foundation

enum FriendAddError: Error {
    case serverError
    case notData
    case decodeError
}

struct FriendAddModel: Codable {
    let response: Int
}

class FriendAdd {
    
    //MARK: - Основной запрос на добавление в друзья
    
    private let urlPath = "https://api.vk.com/method/friends.add"
    
    func getAddFriend(userID: Int, completion: @escaping (Result<FriendAddModel, FriendAddError>) -> Void) {
        let paramters: Parameters = [
            "user_id": "\(userID)",
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
                print(completion)
                return
            }
            do {
                let responseFriendAdd = try JSONDecoder().decode(FriendAddModel.self, from: response.data!)
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
    
    //MARK: - Поиск ошибки
    
    struct ErrorModel: Codable {
        let error: ErrorResponse
    }
    
    struct ErrorResponse: Codable {
        let error_code: Int
        let error_msg: String
    }
    
    private func getAddFriendError(userID: Int, param: Parameters,
                                   completion: @escaping (Result<ErrorModel, FriendAddError>) -> Void) {
        AF.request(urlPath, method: .get, parameters: param).responseJSON { response in
            do {
                let responseFriendAddError = try JSONDecoder().decode(ErrorModel.self, from: response.data!)
                completion(.success(responseFriendAddError))
            } catch {
                completion(.failure(.decodeError))
                print("Ошибка декодирования, неизвестные данные")
                return
            }
        }
    }
}
