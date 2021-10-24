//
//  NewsDataModel.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 25.07.2021.
//

import Foundation

struct NewsDataModel {
    var newsLikeCount: Int
    var newsRepostCount: Int
    var newsViewCount: Int
    var newsIsComment: Bool
    var newsIsLike: Bool {
        didSet {
            newsLikeCount += newsIsLike ? 1 : -1
        }
    }
    var newsIsRepost: Bool {
        didSet {
            newsRepostCount += newsIsRepost ? 1 : -1
        }
    }
}
