//
// Created by Chope on 2017. 1. 10..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation

extension Notification.Name {
    struct Model {
        static let changedIssues: Notification.Name = Notification.Name("changedIssuesInModel")
        static let addedIssues: Notification.Name = Notification.Name("addedIssuesInModel")
        static let changedIssueDetail: Notification.Name = Notification.Name("changedIssueDetailInModel")
        static let changedComments: Notification.Name = Notification.Name("changedCommentsInModel")
        static let addedComment: Notification.Name = Notification.Name("addedCommentInModel")
    }

    struct ViewModel {
        static let changedIssues: Notification.Name = Notification.Name("changedIssuesInViewModel")
        static let addedIssues: Notification.Name = Notification.Name("addedIssuesInViewModel")
        static let changedIssueDetail: Notification.Name = Notification.Name("changedIssueDetailInViewModel")
        static let changedComments: Notification.Name = Notification.Name("changedCommentsInViewModel")
        static let addedComment: Notification.Name = Notification.Name("addedCommentInViewModel")
    }
}
