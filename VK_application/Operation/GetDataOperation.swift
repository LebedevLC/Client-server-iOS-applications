//
//  GetDataOperation.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 05.11.2021.
//

import Foundation
import Alamofire

class GetDataOperation: AsyncOperation {
    private var request: DataRequest
    var data: Data?

    init(request: DataRequest) {
        self.request  = request
    }

    override func main() {
        request.responseData(queue: DispatchQueue.global(qos: .utility)) { [weak self] response in
            self?.data = response.data
            self?.state = .finished
            print("data loaded")
        }
        print("GetDataOperation finished")
    }

    override func cancel() {
        request.cancel()
        super.cancel()
    }
}
