//
//  RealmServices.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 09.10.2021.
//

import RealmSwift

class RealmServices {
    
    /// Filter: Поле которое фильтруем, FilterText: Текст по которому фильтруем,  Array: Объект Realm
    func saveData <T: Object> (filter: String, filterText: Int, array: [T], completion: @escaping () -> Void) {
        do {
            let realm = try Realm()
            let oldArray = realm.objects(T.self).filter("\(filter) == %@", filterText)
            realm.beginWrite()
            realm.delete(oldArray)
            realm.add(array)
            try realm.commitWrite()
            print("добавил/обновил \(array.count) записей")
//            print(realm.configuration.fileURL as Any)
            DispatchQueue.main.async {
                completion()
            }
        } catch { print(error) }
    }
}
