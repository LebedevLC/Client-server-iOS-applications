//
//  GroupsGet.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 22.09.2021.
//

import Foundation
import Alamofire
import RealmSwift

enum GroupsServiceError: Error {
    case decodeError
    case notData
    case serverError
}

class GroupsGet {
    
    private let urlPath = "https://api.vk.com/method/groups.get"
    private let realmService = RealmServices()
    
    func getMyGroups(userId: Int, completion: @escaping () -> Void) {
        
        let paramters: Parameters = [
            "owner_id": "\(String(UserSession.shared.userId))",
            //расширенная информация (да)
            "extended": "1",
            "fields": "description,members_count",
            "access_token": "\(UserSession.shared.token)",
            "v": "5.81"
        ]
        
        AF.request(urlPath, method: .get, parameters: paramters).responseJSON { [weak self] response in
            guard response.data != nil else {
                print("Response from server = nil")
                return
            }
            do {
                let responseGroups = try JSONDecoder().decode(GroupsModel.self, from: response.data!)
                let groups = responseGroups.response.items
                groups.forEach{ $0.ownerId = UserSession.shared.userId}
                self?.realmService.saveData(
                    filter: "ownerId",
                    filterText: UserSession.shared.userId,
                    array: groups,
                    completion: completion)
                completion()
            } catch {
                print("Decode ERROR")
            }
        }
    }
    
}
