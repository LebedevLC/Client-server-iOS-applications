//
//  ProfileSimpleFactory.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 12.12.2021.
//

import Foundation

final class ProfileSimpleFactory {
    
    private let dateFormatterRU = DateFormatterRU()
    
    func constructFriendsModelsCell(from friends: [FriendsItems]) -> [CollectionTableCellModel] {
        return friends.compactMap(self.friendViewModel)
    }
    
    func constructHeadersModelsCell(from headers: [UsersGetItems]) -> [HeaderCellModel] {
        return headers.compactMap(self.headerViewModel)
    }
    
    private func friendViewModel(from friend: FriendsItems) -> CollectionTableCellModel {
        let name = friend.first_name + " " + friend.last_name
        let url = friend.photo_100
        let online = friend.online == 1 ? true : false
        return CollectionTableCellModel(title: name, imageName: url, online: online)
    }
    
    private func headerViewModel(from header: UsersGetItems) -> HeaderCellModel {
        let name = (header.first_name ?? "") + " " + (header.last_name ?? "")
        let status = header.status ?? ""
        let date = self.dateFormatterRU.ShowMeDate(date: header.last_seen?.time ?? 0)
        let avatar = header.photo_100 ?? ""
        return HeaderCellModel(name: name, status: status, date: date, avatar: avatar)
    }
}
