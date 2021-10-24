//
//  PhotoModel.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 11.07.2021.
//

import UIKit

struct PhotoModel {
    let name: String
    let fileName: String
    var likeCount: Int
    var isLike: Bool {
        didSet {
            likeCount += isLike ? 1 : -1
        }
    }
}

