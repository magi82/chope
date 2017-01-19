//
// Created by Chope on 2017. 1. 16..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation

class BitbucketCommentsModel: CommentsModel {
    var user: String
    var repo: String
    var number: Int
    var items: [Comment]

    required init(user: String, repo: String, number: Int) {
        self.user = user
        self.repo = repo
        self.number = number
        self.items = []
    }

    func load() {
        //TODO:
    }

    func create(body: String, failure: ((Error)->Void)? = nil) {
        //TODO:
    }
}
