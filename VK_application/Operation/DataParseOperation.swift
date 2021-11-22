//
//  DataParseOperation.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 05.11.2021.
//

import Foundation

class DataParseOperation: Operation {
    private(set) var outputData: [GroupsItems] = []
    private let decoder = JSONDecoder()

    override func main() {
        guard
            let getDataOperation = dependencies.first as? GetDataOperation,
            let data = getDataOperation.data
        else {
            debugPrint("Data not loaded")
            return
        }

        do {
            let posts = try decoder.decode(GroupsModel.self, from: data)
            outputData = posts.response.items
            debugPrint("Parse Success")
        } catch {
            debugPrint("Data to decode Failed")
        }

    }
}
