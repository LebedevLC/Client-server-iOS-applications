//
//  PtotosGetAll.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 22.09.2021.
//

import Alamofire

class PhotoesGetAll {
    
    /*
     METHOD - photos.getAll
     Cтандартный запрос к API:
     https://api.vk.com/method/METHOD?PARAMS&access_token=TOKEN&v=V
     
     Примерный запрос
     https://api.vk.com/method/photos.getAll?owner_id=123&count=1&no_service_albums=1&access_token=TOKEN&v=5.81
     
     owner_id - ID пользователя чьи фото будем смотреть
     count - колличество отображаемых фото
     no_service_albums:
     0 — вернуть все фотографии (default)
     1 — фотографии только из стандартных альбомов
     */
    
    func getPhotoesAll() {
        // Адресс запроса
        let urlPath = "https://api.vk.com/method/photos.getAll"
        // Параметры запроса
        let paramters: Parameters = [
            "owner_id": "\(String(UserSession.shared.userId))",
            "count": "1",
            // вернуть стандартные альбомы
            "no_service_albums": "1",
            // токен доступа
            "access_token": "\(UserSession.shared.token)",
            // версия API
            "v": "5.81"
        ]
        
        AF.request(urlPath, parameters: paramters).responseJSON { response in
            print("""
                  +++++++++++++++++++++++++++++++++++
                  +++ Starting AF.request PHOTOES +++
                  +++++++++++++++++++++++++++++++++++
                  """)
            print(response.value as Any)
            print("+++++++++++END+++++++++++")
        }
    }
    
}
