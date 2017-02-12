//
// Created by Chope on 2017. 2. 12..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation

class CommentCellViewModel: ItemCellViewModel {
    private var comment: Comment

    init(comment: Comment) {
        self.comment = comment
    }

    var body: String {
        return comment.body
    }

    var username: String? {
        return comment.user?.login
    }

    var userImageURL: URL? {
        return comment.user?.avatarURL
    }
}
