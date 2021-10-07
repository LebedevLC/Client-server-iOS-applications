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
    /*
     METHOD - groups.get - Возвращает список сообществ указанного пользователя.
     Cтандартный запрос к API:
     https://api.vk.com/method/METHOD?PARAMS&access_token=TOKEN&v=V
     
     Примерный запрос
     https://api.vk.com/method/groups.get?v=5.81&owner_id=123&extended=1&fields=description,members_count&access_token=TOKEN

     owner_id - ID пользователя чьи группы получаем
     count - колличество отображаемых групп
     extended - расширенная информация = 1/0
     fields - дополнительные поля (только если extended = 1)
        description - описание сообщества
        members_count - количество подписчиков
     */
    
    // Адресс запроса
    private let urlPath = "https://api.vk.com/method/groups.get"
    
    func getMyGroups(completion: @escaping (Result<[GroupsItems], GroupsServiceError>) -> Void) {
       
        // Параметры запроса
        let paramters: Parameters = [
            "owner_id": "\(String(UserSession.shared.userId))",
            // колличество групп
//            "count": "10",
            //расширенная информация = 1/0
            "extended": "1",
            // дополнительные поля
            "fields": "description,members_count",
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
                let responseGroups = try JSONDecoder().decode(Groups.self, from: response.data!)
                let groups = responseGroups.response.items
                self.saveGroupsData(groups)
                completion(.success(groups))
            } catch {
                completion(.failure(.decodeError))
            }
        }
    }

        // Запись данных в Realm
        func saveGroupsData(_ groups: [GroupsItems]) {
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
}
