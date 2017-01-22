//
// Created by Chope on 2017. 1. 17..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation
import Alamofire
import XCGLogger


enum GithubAPIError: Error {
    case invalidJson
}


class GithubAPI {
    class func initialize() {
        URLCache.shared = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)
    }

    func item<T: GithubData>(router: GithubRouter, success: ((T)->Void)?, failure: ((Error)->Void)?) -> DataRequest {
        logRequest(router: router)

        return Alamofire.request(router).validate().responseJSON {[weak self] response in
            switch response.result {
            case .success:
                guard let json = response.result.value as? [String: Any] else {
                    self?.logFailure(router: router, error: GithubAPIError.invalidJson)
                    failure?(GithubAPIError.invalidJson)
                    return
                }
                self?.logSuccess(router: router, response: response)
                success?(T(rawJson: json))
            case .failure(let error ):
                self?.logFailure(router: router, error: error)
                failure?(error)
            }
        }
    }

    func createItem<T: GithubData>(router: GithubRouter, success: ((T)->Void)?, failure: ((Error)->Void)?) -> DataRequest? {
        guard GithubAuthentication.sharedInstance.accessToken != nil else {
            assertionFailure()
            return nil
        }
        return item(router: router, success: success, failure: failure)
    }

    func logRequest(router: GithubRouter) {
        if let urlRequest = try? router.asURLRequest(), let httpMethod = urlRequest.httpMethod, let urlString = urlRequest.url?.absoluteString {
            XCGLogger.default.info("[\(httpMethod)][Request] \(urlString)")
        }
    }

    func logSuccess(router: GithubRouter, response: DataResponse<Any>) {
        if let urlRequest = try? router.asURLRequest(), let httpMethod = urlRequest.httpMethod, let urlString = urlRequest.url?.absoluteString, let httpURLResponse = response.response {
            XCGLogger.default.info("[\(httpMethod)][Response] \(urlString) : \(httpURLResponse.statusCode)")
        }
    }

    func logFailure(router: GithubRouter, error: Error) {
        if let urlRequest = try? router.asURLRequest(), let httpMethod = urlRequest.httpMethod, let urlString = urlRequest.url?.absoluteString {
            XCGLogger.default.info("[\(httpMethod)][Error] \(urlString) : \(error)")
        }
    }
}
