//
//  ProfileGroupAdapter.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 12.12.2021.
//

import Foundation
import RealmSwift

class ProfileGroupAdapter {
    
    func loadGroupData(groupID: Int, completion: ([GroupsItems]) -> Void) {
        do {
            let realm = try Realm()
            let groupRealm = realm.objects(GroupsItems.self).filter("id == %@", groupID)
            let groups = Array(groupRealm)
            completion(groups)
        } catch { print(error) }
    }
    
}
