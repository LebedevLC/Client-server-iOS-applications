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

class GroupsServices {
    
    private let getUrlPath = "https://api.vk.com/method/groups.get"
    private let searchUrlPath = "https://api.vk.com/method/groups.search"
    private let joinUrlPath = "https://api.vk.com/method/groups.join"
    private let leaveUrlPath = "https://api.vk.com/method/groups.leave"
    private let realmService = RealmServices()
    
    // MARK: - Groups.get
    
    func getMyGroupsReguest() -> DataRequest {
        let paramters: Parameters = [
            "owner_id": "\(String(UserSession.shared.userId))",
            "extended": "1",
            "fields": "description,members_count",
            "access_token": "\(UserSession.shared.token)",
            "v": "\(UserSession.shared.version)"
        ]
        return AF.request(getUrlPath, method: .get, parameters: paramters)
    }
    
    // MARK: - Groups.search
    
    /// Получить список найденных групп по запросу "q" с колличеством "count" (max count=1000)
    func getMyGroups(q: String, count: Int, completion: @escaping (Result<[GroupsSearchItems], GroupsServiceError>) -> Void) {
        var newCount = count
        if count > 1000 {
            newCount = 1000
        }
        let paramters: Parameters = [
            // поисковый запрос
            "q": "\(q)",
            "count": "\(newCount)",
            "access_token": "\(UserSession.shared.token)",
            "v": "\(UserSession.shared.version)"
        ]
        
        AF.request(searchUrlPath, method: .get, parameters: paramters).responseJSON { response in
            if let error = response.error {
                completion(.failure(.serverError))
                debugPrint(error.localizedDescription)
            }
            guard response.data != nil else {
                completion(.failure(.notData))
                return
            }
            do {
                let responseGroups = try JSONDecoder().decode(GroupsSearchModel.self, from: response.data!)
                let groupsSearch = responseGroups.response.items
                self.realmService.saveData(array: groupsSearch)
                completion(.success(groupsSearch))
            } catch {
                completion(.failure(.decodeError))
            }
        }
    }
    
    // MARK: - Groups.join
    
    struct GroupJoinModel: Codable {
        let response: Int
    }
    
    func getJoinGroup(groupID: Int, completion: @escaping (Result<GroupJoinModel, GroupsServiceError>) -> Void) {
        let paramters: Parameters = [
            "group_id": "\(groupID)",
            "access_token": "\(UserSession.shared.token)",
            "v": "\(UserSession.shared.version)"
        ]
        
        AF.request(joinUrlPath, method: .get, parameters: paramters).responseJSON { response in
            if let error = response.error {
                completion(.failure(.serverError))
                debugPrint(error)
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
    
    // MARK: - Groups.leave
    
    struct GroupLeaveModel: Codable {
        let response: Int
    }
    
    func getLeaveGroup(groupID: Int, completion: @escaping (Result<GroupLeaveModel, GroupsServiceError>) -> Void) {
        let paramters: Parameters = [
            "group_id": "\(groupID)",
            "access_token": "\(UserSession.shared.token)",
            "v": "\(UserSession.shared.version)"
        ]
        
        AF.request(leaveUrlPath, method: .get, parameters: paramters).responseJSON { response in
            if let error = response.error {
                completion(.failure(.serverError))
                debugPrint(error)
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
