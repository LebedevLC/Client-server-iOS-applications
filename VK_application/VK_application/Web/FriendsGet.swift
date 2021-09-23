//
//  FriendsGet.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 22.09.2021.
//

import Alamofire

class FriendsGet {
     
    /*
     METHOD - friends.get
     Cтандартный запрос к API:
     https://api.vk.com/method/METHOD?PARAMS&access_token=TOKEN&v=V
     
     Примерный запрос
     https://api.vk.com/method/friends.get?fields=nickname,bdate,city,photo_50&count=1&access_token=TOKEN&v=5.81
    
     fields - поля для получения:
           nickname, domain, sex, bdate, city, country, timezone, photo_50, photo_100, photo_200_orig,
           has_mobile, contacts, education, online, relation, last_seen, status, can_write_private_message,
           can_see_all_posts, can_post, universities
     count - колличество отображаемых друзей
     */
    
    func getFriends() {
        // Адресс запроса
        let urlPath = "https://api.vk.com/method/friends.get"
        // Параметры запроса
        let paramters: Parameters = [
            "fields": "nickname,bdate,city,photo_50",
            "count": "1",
            // токен доступа
            "access_token": "\(UserSession.shared.token)",
            // версия API
            "v": "5.81"
        ]
        
        AF.request(urlPath, parameters: paramters).responseJSON { response in
            print("""
                  +++++++++++++++++++++++++++++++++++
                  +++ Starting AF.request FRIENDS +++
                  +++++++++++++++++++++++++++++++++++
                  """)
            print(response.value as Any)
            print("+++++++++++END+++++++++++")
        }
    }
    
}


