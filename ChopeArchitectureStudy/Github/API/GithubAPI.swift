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

    func items<T: GithubData>(router: GithubRouter, success: (([T], String?)->Void)?, failure: ((Error)->Void)?) -> DataRequest {
        return Alamofire.request(router).validate().responseJSON { response in
            switch response.result {
            case .success:
                guard let json = response.result.value as? [[String: Any]] else {
                    failure?(GithubAPIError.invalidJson)
                    return
                }

                let items: [T] = json.map { T(rawJson: $0) }
                if let linkValue: String = response.response?.allHeaderFields["Link"] as? String {
                    let pattern = "<(.+)>; rel=\"next\""
                    if let regex = try? NSRegularExpression(pattern: pattern, options: []), let match: NSTextCheckingResult = regex.matches(in: linkValue, options: [], range: NSRange(location: 0, length: linkValue.characters.count)).first {
                        let range = match.rangeAt(1)
                        let nextPageUrl = (linkValue as NSString).substring(with: range)
                        success?(items, nextPageUrl)
                        return
                    }
                }
                success?(items, nil)
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
