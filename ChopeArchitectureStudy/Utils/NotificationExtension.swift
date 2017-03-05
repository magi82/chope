//
// Created by Chope on 2017. 1. 10..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation

extension NotificationCenter {
    static let model = NotificationCenter()
    static let interactor = NotificationCenter()
}

extension Notification.Name {
    struct Model {
        static let changedIssues: Notification.Name = Notification.Name("changedIssuesInModel")
        static let addedIssue: Notification.Name = Notification.Name("addedIssueInModel")
        static let changedIssue: Notification.Name = Notification.Name("changedIssueDetailInModel")
        static let changedComments: Notification.Name = Notification.Name("changedCommentsInModel")
        static let addedComment: Notification.Name = Notification.Name("addedCommentInModel")
    }

    struct Interactor {
        static let changedIssues: Notification.Name = Notification.Name("changedIssuesInInteractor")
        static let addedIssue: Notification.Name = Notification.Name("addedIssueInInteractor")
        static let changedIssue: Notification.Name = Notification.Name("changedIssueDetailInInteractor")
        static let changedComments: Notification.Name = Notification.Name("changedCommentsInInteractor")
        static let addedComment: Notification.Name = Notification.Name("addedCommentInInteractor")
    }
}
