//
// Created by Chope on 2017. 1. 15..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation

class CommentsPresenter {
    let model: CommentsModel
    var view: CommentsView!

    init(model: CommentsModel) {
        self.model = model

        NotificationCenter.default.addObserver(self, selector: #selector(onChangedComments), name: Notification.Name.changedComments, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onAddedComment), name: Notification.Name.addedComment, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func onChangedComments() {
        view?.reloadComments()
    }

    @objc func onAddedComment() {
        comments()
    }

    func comments() {
        model.load()
    }

    func count() -> Int {
        return model.items.count
    }

    func display(cell: CommentCellView, atIndex index: Int) {
        let comment = model.items[index]
        cell.set(body: comment.body)

        guard let user = comment.user else { return }
        cell.setUser(name: user.name, photoURL: user.photoUrl)
    }

    func create(body: String) {
        model.create(body: body) { [weak self] (error, s) in
            self?.view.showMessage(title: "\(error)", message: s)
        }
    }
}
