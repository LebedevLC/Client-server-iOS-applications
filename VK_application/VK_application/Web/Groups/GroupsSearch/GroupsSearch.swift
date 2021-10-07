//
//  GroupsSearch.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 22.09.2021.
//

import Foundation
import Alamofire
import RealmSwift

class GroupsSearch {
    
   private let urlPath = "https://api.vk.com/method/groups.search"
   private let joinUrlPath = "https://api.vk.com/method/groups.join"
   private let leaveUrlPath = "https://api.vk.com/method/groups.leave"
    
    /// Получить список найденных групп по запросу "q" с колличеством "count" (max count=1000)
    func getMyGroups(q: String, count: Int, completion: @escaping (Result<[GroupsSearchItems], GroupsServiceError>) -> Void) {
        var newCount = count
        if count > 1000 {
            newCount = 1000
        }
        let paramters: Parameters = [
            // поисковый запрос
            "q": "\(q)",
            // колличество
            "count": "\(newCount)",
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
                let responseGroups = try JSONDecoder().decode(GroupsSearchModel.self, from: response.data!)
                let groupsSearch = responseGroups.response.items
                // включить для записи в реалм
//                self.saveGroupsSearchData(groupsSearch)
                completion(.success(groupsSearch))
            } catch {
                completion(.failure(.decodeError))
            }
        }
    }

        // Запись данных в Realm
       private func saveGroupsSearchData(_ groups: [GroupsSearchItems]) {
            do {
                let realm = try Realm()
                realm.beginWrite()
                print("начинаю запись данных в Realm")
                realm.add(groups)
                print("добавляю запись")
                try realm.commitWrite()
                print("добавил \(groups.count) записей")
                print("заканчиваю запись и сохраняю изменения")
            } catch {
                print(error)
            }
        }
    
//MARK: - Groups.join
    
    struct GroupJoinModel: Codable {
        let response: Int
    }
    
    func getJoinGroup(groupID: Int, completion: @escaping (Result<GroupJoinModel, GroupsServiceError>) -> Void) {
        let paramters: Parameters = [
            "group_id": "\(groupID)",
            // токен доступа
            "access_token": "\(UserSession.shared.token)",
            // версия API
            "v": "5.81"
        ]
        
        AF.request(joinUrlPath, method: .get, parameters: paramters).responseJSON { response in
            if let error = response.error {
                completion(.failure(.serverError))
                print(error)
            }
            guard response.data != nil else {
                completion(.failure(.notData))
                return
            }
            do {
                let responseGroupsJoin = try JSONDecoder().decode(GroupJoinModel.self, from: response.data!)
                completion(.success(responseGroupsJoin))
            } catch {
                completion(.failure(.decodeError))
            }
        }
    }
    
//MARK: - Groups.leave
    
    struct GroupLeaveModel: Codable {
        let response: Int
    }
    
    func getLeaveGroup(groupID: Int, completion: @escaping (Result<GroupLeaveModel, GroupsServiceError>) -> Void) {
        let paramters: Parameters = [
            // поисковый запрос
            "group_id": "\(groupID)",
            // токен доступа
            "access_token": "\(UserSession.shared.token)",
            // версия API
            "v": "5.81"
        ]
        
        AF.request(leaveUrlPath, method: .get, parameters: paramters).responseJSON { response in
            if let error = response.error {
                completion(.failure(.serverError))
                print(error)
            }
            guard response.data != nil else {
                completion(.failure(.notData))
                return
            }
            do {
                let responseGroupsLeave = try JSONDecoder().decode(GroupLeaveModel.self, from: response.data!)
                completion(.success(responseGroupsLeave))
            } catch {
                completion(.failure(.decodeError))
            }
        }
    }
    
}
