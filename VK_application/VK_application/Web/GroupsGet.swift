//
//  GroupsGet.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 22.09.2021.
//

import Alamofire

class GroupsGet {
    /*
     METHOD - groups.get
     Cтандартный запрос к API:
     https://api.vk.com/method/METHOD?PARAMS&access_token=TOKEN&v=V
     
     Примерный запрос
     https://api.vk.com/method/groups.get?owner_id=123&count=10&access_token=TOKEN&v=5.81
     
     owner_id - ID пользователя чьи группы получаем
     count - колличество отображаемых групп
     */
    
    func getMyGroups() {
        // Адресс запроса
        let urlPath = "https://api.vk.com/method/groups.get"
        // Параметры запроса
        let paramters: Parameters = [
            "owner_id": "\(String(UserSession.shared.userId))",
            // колличество групп
            "count": "10",
            // токен доступа
            "access_token": "\(UserSession.shared.token)",
            // версия API
            "v": "5.81"
        ]
        
        AF.request(urlPath, parameters: paramters).responseJSON { response in
            print("""
                  +++++++++++++++++++++++++++++++++++
                  +++ Starting AF.request GROUPS ++++
                  +++++++++++++++++++++++++++++++++++
                  """)
            print(response.value as Any)
            print("+++++++++++END+++++++++++")
        }
    }
}
