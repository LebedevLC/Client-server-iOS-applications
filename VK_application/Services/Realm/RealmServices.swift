//
//  RealmServices.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 09.10.2021.
//

import RealmSwift

class RealmServices {
    
    /// Сохранение массива выборочных данных и удаление старых
    /// Filter: Поле которое фильтруем, FilterText: Текст по которому фильтруем,  Array: Объект Realm
    func saveData <T: Object> (filter: String, filterText: Int, array: [T], completion: @escaping () -> Void) {
        do {
            let realm = try Realm()
            let oldArray = realm.objects(T.self).filter("\(filter) == %@", filterText)
            realm.beginWrite()
            realm.delete(oldArray)
            realm.add(array)
            try realm.commitWrite()
//            print("добавил/обновил \(array.count) записей")
//            print(realm.configuration.fileURL as Any)
            DispatchQueue.main.async {
                completion()
            }
        } catch { print(error) }
    }
    
    /// Сохранение выборочных данных и удаление старых
    /// Filter: Поле которое фильтруем, FilterText: Текст по которому фильтруем,  Object: Объект Realm (не массив)
    func saveSingleData <T: Object> (filter: String, filterText: Int, object: T, completion: @escaping () -> Void) {
        do {
            let realm = try Realm()
            let oldObject = realm.objects(T.self).filter("\(filter) == %@", filterText)
            realm.beginWrite()
            realm.delete(oldObject)
            realm.add(object)
            try realm.commitWrite()
            print(realm.configuration.fileURL as Any)
            DispatchQueue.main.async {
                completion()
            }
        } catch { print(error) }
    }
    
    /// Запись массива данных в Realm
    /// array: Объект Realm
    func saveData <T: Object> (array: [T]) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            print("Начинаю запись данных в Realm")
            realm.add(array)
            try realm.commitWrite()
            print("Добавил \(array.count) записей")
        } catch {
            print(error)
        }
    }
    
//    func saveFriendsData(_ friends: [FriendsItems]) {
//        // обработка исключений при работе с хранилищем
//        do {
//            let realm = try Realm()
//            // получаем friends
//            try friends.forEach{
//                guard let friend = realm.object(ofType: FriendsDataRealm.self, forPrimaryKey: $0.id) else { return }
//            let oldData = friend.friends
//            realm.beginWrite()
//            realm.delete(oldData)
//            friend.friends.append(objectsIn: friends)
//                try realm.commitWrite()
//
//            }
//        } catch {
//            print(error)
//        }
//    }
    
}
