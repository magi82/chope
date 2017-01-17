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
    let user: String
    let repo: String

    init(user: String, repo: String) {
        self.user = user
        self.repo = repo
    }

    func items<T: GithubData>(router: GithubRouter, success: (([T])->Void)?, failure: ((Error)->Void)?) -> DataRequest {
        return Alamofire.request(router).validate().responseJSON { response in
            switch response.result {
            case .success:
                guard let json = response.result.value as? [[String: Any]] else {
                    failure?(GithubAPIError.invalidJson)
                    return
                }

                if let linkInHeader: String = response.response?.allHeaderFields["Link"] as? String {
                    if let link = linkInHeader.components(separatedBy: ",").filter({ $0.contains("rel=\"next\"") }).first {
                        var result = Array(link.characters)
                                .map { String($0) }
                                .split { $0 == ">" || $0 == "<" }
//                        result = result.flatMap { (value: ArraySlice<String>) -> String in  String(Array(value)) }
//                        result = result.flatMap { String($0) }
                        dump(result)
                    }
                }
                success?(json.map { T(rawJson: $0) })
            case .failure(let error):
                failure?(error)
            }
        }
    }

    func item<T: GithubData>(router: GithubRouter, success: ((T)->Void)?, failure: ((Error)->Void)?) -> DataRequest {
        return Alamofire.request(router).validate().responseJSON { response in
            switch response.result {
            case .success:
                guard let json = response.result.value as? [String: Any] else {
                    failure?(GithubAPIError.invalidJson)
                    return
                }
                success?(T(rawJson: json))
            case .failure(let error):
                failure?(error)
            }
        }
    }
}
