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
    private let dispatchGroup = DispatchGroup()
    var dispatchQueueJsonResponse: NewsFeedResponse?
    
    func getNewsFeedPost(count: Int, completion: @escaping (Result<NewsFeedResponse, SimpleServiceError>) -> Void) {
        let paramters: Parameters = [
            "filters": "post",
            "count": "\(count)",
            "access_token": "\(UserSession.shared.token)",
            "v": "\(UserSession.shared.version)"
        ]
        
        AF.request(feedUrlPath, method: .get, parameters: paramters).responseJSON { response in
            if let error = response.error {
                print("server Error!")
                print(error)
            }
            guard response.data != nil else {
                print("Error - not Data!")
                return
            }
            self.tryJson(data: response)
            self.dispatchGroup.notify(queue: DispatchQueue.main) {
                if let response = self.dispatchQueueJsonResponse {
                    completion(.success(response))
                } else {
                    completion(.failure(.decodeError))
                }
            }
        }
    }
    
    func tryJson(data: AFDataResponse<Any>) {
        DispatchQueue.global().async(group: dispatchGroup, qos: .utility) {
            do {
                let responseFeed = try JSONDecoder().decode(NewsFeedModel.self, from: data.data!)
                let feed = responseFeed.response
                self.dispatchQueueJsonResponse = feed
            } catch {
                print("DispatchQueue.global.async(group: dispatchGroup) JSON Decode ERROR")
                self.dispatchQueueJsonResponse = nil
            }
        }
    }
}
