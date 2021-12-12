//
//  AccountServices.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 14.10.2021.
//

import Foundation
import Alamofire
import RealmSwift

class AccountServices {
    
    private let getProfileInfoUrlPath = "https://api.vk.com/method/account.getProfileInfo"
    private let realmService = RealmServices()
    
    // MARK: - Возвращает информацию о текущем профиле
    
    func getProfileInfo(completion: @escaping () -> Void) {
        let paramters: Parameters = [
            "access_token": "\(UserSession.shared.token)",
            "v": "\(UserSession.shared.version)"
        ]
        
        AF.request(getProfileInfoUrlPath, method: .get, parameters: paramters).responseJSON { [weak self] response in
            guard response.data != nil else {
                print("Response from server = nil")
                return
            }
            do {
                let responseProfileInfo = try JSONDecoder().decode(AccountModel.self, from: response.data!)
                let profileInfo = responseProfileInfo.response
                self?.realmService.saveSingleData(
                    filter: "id",
                    filterText: UserSession.shared.userId,
                    object: profileInfo,
                    completion: completion)
                completion()
            } catch {
                print("Decode ERROR")
            }
        }
    }
}
