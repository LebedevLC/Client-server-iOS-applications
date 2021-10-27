//
//  NewsFeedServices.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 26.10.2021.
//

import Foundation
import Alamofire

class NewsFeedServices {

    private let feedUrlPath = "https://api.vk.com/method/newsfeed.get"
    
    func getNewsFeedPost(count: Int, completion: @escaping (Result<NewsFeedResponse, SimpleServiceError>) -> Void) {
        let paramters: Parameters = [
            "filters": "post",
            "count": "\(count)",
            "access_token": "\(UserSession.shared.token)",
            "v": "\(UserSession.shared.v)"
        ]
        
        AF.request(feedUrlPath, method: .get, parameters: paramters).responseJSON { response in
            if let error = response.error {
                completion(.failure(.serverError))
                print("server Error!")
                print(error)
            }
            guard response.data != nil else {
                completion(.failure(.notData))
                print("Error - not Data!")
                return
            }
            do {
                let responseFeed = try JSONDecoder().decode(NewsFeedModel.self, from: response.data!)
                let feed = responseFeed.response
                completion(.success(feed))
            } catch {
                completion(.failure(.decodeError))
                print("Decode Error")
            }
        }
    }
    
}
