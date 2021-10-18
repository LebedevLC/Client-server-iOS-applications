//
//  PtotosGetAll.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 22.09.2021.
//

import Foundation
import Alamofire
import RealmSwift

class PhotoesServices {
    
    private let allUrlPath = "https://api.vk.com/method/photos.getAll"
    private let getAlbumUrlPath = "https://api.vk.com/method/photos.get"
    private let realmService = RealmServices()
    
    //MARK: - Все фотографии
    
    func getPhotoesAll(ownerID: Int, completion: @escaping () -> Void) {
        let paramters: Parameters = [
            "owner_id": "\(ownerID)",
            // колличесвто фотографий максимум 200, стандартно 20
            "count": "199",
            // расширенная информация (да)
            "extended": "1",
            // вернуть стандартные альбомы (нет)
            "no_service_albums": "0",
            "access_token": "\(UserSession.shared.token)",
            "v": "\(UserSession.shared.v)"
        ]
        
        AF.request(allUrlPath, method: .get, parameters: paramters).responseJSON { [weak self] response in
            guard response.data != nil else {
                print("Response from server = nil")
                return
            }
            do {
                let responsePhotoes = try JSONDecoder().decode(PhotoesModel.self, from: response.data!)
                let photoes = responsePhotoes.response.items
                photoes.forEach{ $0.id = ownerID}
                self?.realmService.saveData(
                    filter: "id",
                    filterText: ownerID,
                    array: photoes,
                    completion: completion)
                completion()
            } catch {
                print("Decode ERROR")
            }
        }
    }
    
    //MARK: - Получить альбом
    
    func getAlbumPhotoes(ownerID: Int, completion: @escaping () -> Void) {
        let paramters: Parameters = [
            "owner_id": "\(ownerID)",
            "count": "1",
            // вернуть альбом профиля
            "album_id": "profile",
            // расширенная информация (да)
            "extended": "1",
            "access_token": "\(UserSession.shared.token)",
            "v": "\(UserSession.shared.v)"
        ]
        
        AF.request(allUrlPath, method: .get, parameters: paramters).responseJSON { [weak self] response in
            guard response.data != nil else {
                print("Response from server = nil")
                return
            }
            do {
                let responsePhotoes = try JSONDecoder().decode(PhotoesModel.self, from: response.data!)
                let photoes = responsePhotoes.response.items
                photoes.forEach{ $0.id = ownerID}
                self?.realmService.saveData(
                    filter: "id",
                    filterText: ownerID,
                    array: photoes,
                    completion: completion)
                completion()
            } catch {
                print("Decode ERROR")
            }
        }
    }
}
