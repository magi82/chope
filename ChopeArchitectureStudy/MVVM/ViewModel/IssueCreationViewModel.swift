//
// Created by Chope on 2017. 2. 12..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation

class IssueCreationViewModel {
    var data: ModelData
    let model: IssueDetailModel

    init(data: ModelData) {
        self.data = data
        self.model = GithubIssueDetailModel(data: data)
    }

    func postIssue(title: String, body: String) {
        model.create(title: title, body: body) { error in
        }
    }
}
