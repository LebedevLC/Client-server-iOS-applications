//
//  NewsModel.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 25.07.2021.
//

import Foundation

struct NewsModel {
    let user: [FriendModel]
    let data: String
    let newsImageName: String
    let text: String
    var newsDataModel: [NewsDataModel]
}
