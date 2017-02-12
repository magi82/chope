//
// Created by Chope on 2017. 1. 10..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation

extension Notification.Name {
    struct Model {
        static let changedIssues: Notification.Name = Notification.Name("changedIssuesInModel")
        static let addedIssue: Notification.Name = Notification.Name("addedIssueInModel")
        static let changedIssue: Notification.Name = Notification.Name("changedIssueDetailInModel")
        static let changedComments: Notification.Name = Notification.Name("changedCommentsInModel")
        static let addedComment: Notification.Name = Notification.Name("addedCommentInModel")
    }

    struct ViewModel {
        static let changedIssues: Notification.Name = Notification.Name("changedIssuesInViewModel")
        static let addedIssue: Notification.Name = Notification.Name("addedIssueInViewModel")
        static let changedIssueDetail: Notification.Name = Notification.Name("changedIssueDetailInViewModel")
        static let changedComments: Notification.Name = Notification.Name("changedCommentsInViewModel")
        static let addedComment: Notification.Name = Notification.Name("addedCommentInViewModel")
    }
}
