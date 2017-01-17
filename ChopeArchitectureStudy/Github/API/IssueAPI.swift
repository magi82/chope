//
// Created by Chope on 2017. 1. 17..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation
import Alamofire

class IssueAPI: GithubAPI {
    override init(user: String, repo: String) {
        super.init(user: user, repo: repo)
    }

    @discardableResult
    func issues(success: (([Issue])->Void)?, failure: ((Error)->Void)?) -> DataRequest {
        return items(router: .issues(user: user, repo: repo), success: success, failure: failure)
    }
}
