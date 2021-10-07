//
//  PtotosGetAll.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 22.09.2021.
//
import Foundation
import Alamofire
import RealmSwift

enum PhotoesServiceError: Error {
    case decodeError
    case notData
    case serverError
}

class PhotoesGetAll {
    
    /*
     METHOD - photos.getAll
     Cтандартный запрос к API:
     https://api.vk.com/method/METHOD?PARAMS&access_token=TOKEN&v=V
     
     Примерный запрос
     https://api.vk.com/method/photos.getAll?owner_id=123&count=1&no_service_albums=1&access_token=TOKEN&v=5.81
     
     owner_id - ID пользователя чьи фото будем смотреть
     count - колличество отображаемых фото
     extended - расширенная инфформация о фото
     no_service_albums:
     0 — вернуть все фотографии (default)
     1 — фотографии только из стандартных альбомов
     */
    
    // Адресс запроса
    private let urlPath = "https://api.vk.com/method/photos.getAll"
    
    func getPhotoesAll(ownerID: Int, completion: @escaping (Result<[PhotoesItems], PhotoesServiceError>) -> Void) {
        // Параметры запроса
        let paramters: Parameters = [
            // target ID
            "owner_id": "\(ownerID)",
            // колличесвто фотографий максимум 200, стандартно 20
            "count": "199",
            // расширенная информация
            "extended": "1",
            // вернуть стандартные альбомы
            "no_service_albums": "0",
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
                let responsePhotoes = try JSONDecoder().decode(Photoes.self, from: response.data!)
                let photoes = responsePhotoes.response.items
                self.savePhotoesData(photoes)
                completion(.success(photoes))
            } catch {
                completion(.failure(.decodeError))
            }
        }
    }
    // Запись данных в Realm
    func savePhotoesData(_ photoes: [PhotoesItems]) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            print("начинаю запись данных в Realm")
            realm.add(photoes)
            print("добавляю запись")
            try realm.commitWrite()
            print("добавил \(photoes.count) записей")
            print("заканчиваю запись и сохраняю изменения")
        } catch {
            print(error)
        }
    }
    
}
