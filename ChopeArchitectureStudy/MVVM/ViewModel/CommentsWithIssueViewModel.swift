//
// Created by Chope on 2017. 2. 12..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation
import CPGithub
import ChopeLibrary


extension Comment: Item {

}


class CommentsWithIssueViewModel: GithubItemsViewModel {
    var data: ModelData

    private let issueModel: IssueDetailModel
    private let commentsModel: CommentsModel

    var title: String {
        return issueModel.issue.title
    }

    init(data: ModelData, issueNumber: Int) {
        self.data = data.withNumber(number: issueNumber)
        self.issueModel = IssueDetailModel(data: self.data)
        self.commentsModel = CommentsModel(data: self.data)

        NotificationCenter.default.addObserver(self, selector: #selector(onChangedComments), name: Notification.Name.Model.changedComments, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onAddedComment), name: Notification.Name.Model.addedComment, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onChangedIssueDetail), name: Notification.Name.Model.changedIssue, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func modelData() -> ModelData {
        return self.data
    }

    var numberOfItems: Int {
        return commentsModel.items.count + 1
    }

    func itemCellType(atIndex index: Int) -> ItemCellType {
        return index == 0 ? .header : .item
    }

    func itemCellViewModel(atIndex index: Int) -> ItemCellViewModel {
        if index == 0 {
            let issue = issueModel.issue
            return IssueCellViewModel(issue: issue)
        }
        let comment = item(atIndex: index) as! Comment
        return CommentCellViewModel(comment: comment)
    }

    func item(atIndex index: Int) -> Item {
        return index == 0 ? issueModel.issue : commentsModel.items[index-1]
    }

    func loadFirst() {
        issueModel.load()
        commentsModel.load()
    }

    func loadNext() {
        commentsModel.loadNext()
    }

    @objc func onChangedComments() {
        NotificationCenter.default.post(name: Notification.Name.ViewModel.changedComments, object: nil)
    }

    @objc func onAddedComment() {
        loadFirst()

        NotificationCenter.default.post(name: Notification.Name.ViewModel.addedComment, object: nil)
    }

    @objc func onChangedIssueDetail() {
        NotificationCenter.default.post(name: Notification.Name.ViewModel.changedIssueDetail, object: nil)
    }

    func postComment(body: String) {
        commentsModel.create(body: body) { error in
        }
    }
}