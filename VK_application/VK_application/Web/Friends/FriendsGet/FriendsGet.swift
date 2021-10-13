//
//  FriendsGet.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 22.09.2021.
//

import Foundation
import Alamofire
import RealmSwift

class FriendsGet {
    
    private let urlPath = "https://api.vk.com/method/friends.get"
    private let realmService = RealmServices()
    
    func getFriends(userId: Int, completion: @escaping () -> Void) {
        let paramters: Parameters = [
            "fields": "nickname,bdate,city,photo_100",
            "access_token": "\(UserSession.shared.token)",
            "v": "5.81"
        ]
        AF.request(urlPath, method: .get, parameters: paramters).responseJSON { [weak self] response in
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
                    completion: completion)
                completion()
            } catch {
                print("Decode ERROR")
            }
        }
    }
}

