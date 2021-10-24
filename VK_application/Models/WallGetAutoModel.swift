////
////  WallGetAutoModel.swift
////  VK_application
////
////  Created by Сергей Чумовских  on 14.10.2021.
////
//
//// This file was generated from JSON Schema using quicktype, do not modify it directly.
//// To parse the JSON, add this file to your project and do:
////
////   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)
//
//import Foundation
//
//// MARK: - Welcome
//struct Welcome: Codable {
//    let response: Response
//}
//
//// MARK: - Response
//struct Response: Codable {
//    let count: Int
//    let items: [Item]
//}
//
//// MARK: - Item
//class Item: Codable {
//    let id, fromID, ownerID, date: Int
//    let postType, text: String
//    let copyHistory: [CopyHistory]
//    let canDelete, canPin, isPinned: Int
//    let canArchive, isArchived: Bool
//    let postSource: PostSource
//    let comments: Comments
//    let likes: Likes
//    let reposts: Reposts
//    let views: Views
//    let isFavorite: Bool
//    let donut: Donut
//    let shortTextRate: Double
//    let hash: String
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case fromID
//        case ownerID
//        case date
//        case postType
//        case text
//        case copyHistory
//        case canDelete
//        case canPin
//        case isPinned
//        case canArchive
//        case isArchived
//        case postSource
//        case comments, likes, reposts, views
//        case isFavorite
//        case donut
//        case shortTextRate
//        case hash
//    }
//
//    init(id: Int, fromID: Int, ownerID: Int, date: Int, postType: String, text: String, copyHistory: [CopyHistory], canDelete: Int, canPin: Int, isPinned: Int, canArchive: Bool, isArchived: Bool, postSource: PostSource, comments: Comments, likes: Likes, reposts: Reposts, views: Views, isFavorite: Bool, donut: Donut, shortTextRate: Double, hash: String) {
//        self.id = id
//        self.fromID = fromID
//        self.ownerID = ownerID
//        self.date = date
//        self.postType = postType
//        self.text = text
//        self.copyHistory = copyHistory
//        self.canDelete = canDelete
//        self.canPin = canPin
//        self.isPinned = isPinned
//        self.canArchive = canArchive
//        self.isArchived = isArchived
//        self.postSource = postSource
//        self.comments = comments
//        self.likes = likes
//        self.reposts = reposts
//        self.views = views
//        self.isFavorite = isFavorite
//        self.donut = donut
//        self.shortTextRate = shortTextRate
//        self.hash = hash
//    }
//}
//
//// MARK: - Comments
//class Comments: Codable {
//    let canPost, canClose, count: Int
//    let groupsCanPost: Bool
//
//    enum CodingKeys: String, CodingKey {
//        case canPost
//        case canClose
//        case count
//        case groupsCanPost
//    }
//
//    init(canPost: Int, canClose: Int, count: Int, groupsCanPost: Bool) {
//        self.canPost = canPost
//        self.canClose = canClose
//        self.count = count
//        self.groupsCanPost = groupsCanPost
//    }
//}
//
//// MARK: - CopyHistory
//class CopyHistory: Codable {
//    let id, ownerID, fromID, date: Int
//    let postType, text: String
//    let attachments: [Attachment]
//    let postSource: PostSource
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case ownerID
//        case fromID
//        case date
//        case postType
//        case text, attachments
//        case postSource
//    }
//
//    init(id: Int, ownerID: Int, fromID: Int, date: Int, postType: String, text: String, attachments: [Attachment], postSource: PostSource) {
//        self.id = id
//        self.ownerID = ownerID
//        self.fromID = fromID
//        self.date = date
//        self.postType = postType
//        self.text = text
//        self.attachments = attachments
//        self.postSource = postSource
//    }
//}
//
//// MARK: - Attachment
//class Attachment: Codable {
//    let type: AttachmentType
//    let photo: Photo
//
//    init(type: AttachmentType, photo: Photo) {
//        self.type = type
//        self.photo = photo
//    }
//}
//
//// MARK: - Photo
//class Photo: Codable {
//    let albumID, date, id, ownerID: Int
//    let hasTags: Bool
//    let accessKey: String
//    let sizes: [Size]
//    let text: String
//    let userID: Int
//
//    enum CodingKeys: String, CodingKey {
//        case albumID
//        case date, id
//        case ownerID
//        case hasTags
//        case accessKey
//        case sizes, text
//        case userID
//    }
//
//    init(albumID: Int, date: Int, id: Int, ownerID: Int, hasTags: Bool, accessKey: String, sizes: [Size], text: String, userID: Int) {
//        self.albumID = albumID
//        self.date = date
//        self.id = id
//        self.ownerID = ownerID
//        self.hasTags = hasTags
//        self.accessKey = accessKey
//        self.sizes = sizes
//        self.text = text
//        self.userID = userID
//    }
//}
//
//// MARK: - Size
//class Size: Codable {
//    let height: Int
//    let url: String
//    let type: SizeType
//    let width: Int
//
//    init(height: Int, url: String, type: SizeType, width: Int) {
//        self.height = height
//        self.url = url
//        self.type = type
//        self.width = width
//    }
//}
//
//enum SizeType: String, Codable {
//    case m = "m"
//    case o = "o"
//    case p = "p"
//    case q = "q"
//    case r = "r"
//    case s = "s"
//    case x = "x"
//    case y = "y"
//    case z = "z"
//}
//
//enum AttachmentType: String, Codable {
//    case photo = "photo"
//}
//
//// MARK: - PostSource
//class PostSource: Codable {
//    let type: String
//
//    init(type: String) {
//        self.type = type
//    }
//}
//
//// MARK: - Donut
//class Donut: Codable {
//    let isDonut: Bool
//
//    enum CodingKeys: String, CodingKey {
//        case isDonut
//    }
//
//    init(isDonut: Bool) {
//        self.isDonut = isDonut
//    }
//}
//
//// MARK: - Likes
//class Likes: Codable {
//    let canLike, count, userLikes, canPublish: Int
//
//    enum CodingKeys: String, CodingKey {
//        case canLike
//        case count
//        case userLikes
//        case canPublish
//    }
//
//    init(canLike: Int, count: Int, userLikes: Int, canPublish: Int) {
//        self.canLike = canLike
//        self.count = count
//        self.userLikes = userLikes
//        self.canPublish = canPublish
//    }
//}
//
//// MARK: - Reposts
//class Reposts: Codable {
//    let count, wallCount, mailCount, userReposted: Int
//
//    enum CodingKeys: String, CodingKey {
//        case count
//        case wallCount
//        case mailCount
//        case userReposted
//    }
//
//    init(count: Int, wallCount: Int, mailCount: Int, userReposted: Int) {
//        self.count = count
//        self.wallCount = wallCount
//        self.mailCount = mailCount
//        self.userReposted = userReposted
//    }
//}
//
//// MARK: - Views
//class Views: Codable {
//    let count: Int
//
//    init(count: Int) {
//        self.count = count
//    }
//}
