//
// Created by Chope on 2017. 1. 10..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation
import Alamofire
import XCGLogger

protocol IssuesModel {
    var user: String { get set }
    var repo: String { get set }
    var issues: [Issue] { get set }

    init(user: String, repo: String)

    func load()
    func detailModel(index: Int) -> IssueDetailModel
}

extension IssuesModel {
    func postNotification() {
        NotificationCenter.default.post(name: Notification.Name.changedIssues, object: nil)
    }
}