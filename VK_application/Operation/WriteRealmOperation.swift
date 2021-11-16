//
//  WriteRealmOperation.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 05.11.2021.
//

import Foundation
import RealmSwift

class WriteRealmOperation: Operation {
    
    private let realmService = RealmServices()
    
    override func main() {
        guard let parsedData = dependencies.first as? DataParseOperation else {
            debugPrint("Data not parsed")
            return
        }
        let posts = parsedData.outputData
        posts.forEach{ $0.ownerId = UserSession.shared.userId}
        self.realmService.saveData(
            filter: "ownerId",
            filterText: UserSession.shared.userId,
            array: posts,
            completion: { })
        debugPrint("Write Realm success")
    }
}
