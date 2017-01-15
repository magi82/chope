//
// Created by Chope on 2017. 1. 10..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation
import Alamofire
import XCGLogger

protocol IssuesModel: Model {
    var issues: [Issue] { get set }

    init(user: String, repo: String)

    func load()
    func detailModel(index: Int) -> IssueDetailModel
    func detailModel() -> IssueDetailModel
    func commentsModel(index: Int) -> CommentsModel
}

extension IssuesModel {
    func postNotificationChanged() {
        NotificationCenter.default.post(name: Notification.Name.changedIssues, object: nil)
    }
}