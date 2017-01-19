//
// Created by Chope on 2017. 1. 17..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation
import Alamofire

class IssueAPI: PaginationAPI {
    private let user: String
    private let repo: String

    init(user: String, repo: String) {
        self.user = user
        self.repo = repo
    }

    @discardableResult
    func issues(success: (([Issue])->Void)?, failure: ((Error)->Void)?) -> DataRequest {
        return load(router: .issues(user: user, repo: repo), success: success, failure: failure)
    }

    @discardableResult
    func issue(number: Int, success: ((Issue)->Void)?, failure: ((Error)->Void)?) -> DataRequest {
        return item(router: .issue(user: user, repo: repo, number: number), success: success, failure: failure)
    }

    @discardableResult
    func create(title: String, body: String, success: ((Issue)->Void)?, failure: ((Error)->Void)?) -> DataRequest? {
        return createItem(router: .createIssue(user: user, repo: repo, parameters: [
                "title": title,
                "body": body
        ]), success: success, failure: failure)
    }
}
