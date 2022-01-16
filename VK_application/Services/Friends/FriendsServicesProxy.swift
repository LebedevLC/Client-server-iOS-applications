//
//  FriendsServicesProxy.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 24.12.2021.
//

import Foundation

class FriendsServiceProxy: FriendsServiceInterface {
    
    let friendsServices: FriendsServices
    
    init(friendsServices: FriendsServices) {
        self.friendsServices = friendsServices
    }
    
    func getFriends(userId: Int, order: Order) {
        self.friendsServices.getFriends(userId: userId, order: order)
        debugPrint("FriendsServiceProxy is used by userID: \(userId), order: \(order)")
    }
}
