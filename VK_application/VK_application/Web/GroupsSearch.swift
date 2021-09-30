//
//  GroupsSearch.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 22.09.2021.
//

import Alamofire

class GroupsSearch {
    /*
     METHOD - groups.search
     Cтандартный запрос к API:
     https://api.vk.com/method/METHOD?PARAMS&access_token=TOKEN&v=V
     
     Примерный запрос
     https://api.vk.com/method/groups.search?q=apple&count=10&access_token=TOKEN&v=5.81
     
     q - текст поискового запроса. ОБЯЗАТЕЛЬНЫЙ параметр
     count - колличество отображаемых групп
     */
    
    func getMyGroups() {
        // Адресс запроса
        let urlPath = "https://api.vk.com/method/groups.search"
        // Параметры запроса
        let paramters: Parameters = [
            // поисковый запрос
            "q": "Apple",
            // колличество групп
            "count": "2",
            // токен доступа
            "access_token": "\(UserSession.shared.token)",
            // версия API
            "v": "5.81"
        ]
        
        AF.request(urlPath, parameters: paramters).responseJSON { response in
//            print("""
//                  ++++++++++++++++++++++++++++++++++++++++++
//                  +++ Starting AF.request SEARCH_GROUPS ++++
//                  ++++++++++++++++++++++++++++++++++++++++++
//                  """)
//            print(response.value as Any)
//            print("+++++++++++END+++++++++++")
        }
    }
    
}
