//
// Created by Chope on 2017. 1. 17..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation
import Alamofire

class CommentAPI: GithubAPI {
    override init(user: String, repo: String) {
        super.init(user: user, repo: repo)
    }

    @discardableResult
    func comments(issueNumber: Int, success: (([Comment])->Void)?, failure: ((Error)->Void)?) -> DataRequest {
        return items(router: .comments(user: user, repo: repo, number: issueNumber), success: success, failure: failure)
    }
}
