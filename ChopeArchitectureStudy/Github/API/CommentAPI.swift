//
// Created by Chope on 2017. 1. 17..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation
import Alamofire

class CommentAPI: PaginationAPI {
    private let user: String
    private let repo: String

    init(user: String, repo: String) {
        self.user = user
        self.repo = repo
    }

    @discardableResult
    func comments(issueNumber: Int, success: (([Comment])->Void)?, failure: ((Error)->Void)?) -> DataRequest {
        return load(router: .comments(user: user, repo: repo, number: issueNumber), success: success, failure: failure)
    }

    @discardableResult
    func create(issueNumber: Int, body: String, success: ((Issue)->Void)?, failure: ((Error)->Void)?) -> DataRequest? {
        return createItem(router: .createComment(user: user, repo: repo, number: issueNumber, parameters: [
                "body": body
        ]), success: success, failure: failure)
    }
}
