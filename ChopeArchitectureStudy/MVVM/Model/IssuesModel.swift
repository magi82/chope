//
// Created by Chope on 2017. 1. 10..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation
import Alamofire
import XCGLogger

protocol IssuesModel: Model {
    var issues: [Issue] { get set }

    func load()
    func loadNext()
}

extension IssuesModel {
    func postNotificationChanged() {
        NotificationCenter.default.post(name: Notification.Name.Model.changedIssues, object: nil)
    }
}