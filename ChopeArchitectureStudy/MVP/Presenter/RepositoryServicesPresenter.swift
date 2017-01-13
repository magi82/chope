//
// Created by Chope on 2017. 1. 10..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation

class RepositoryServicesPresenter {
    let model = RepositoryServicesModel()
    let view: RepositoryServicesView

    init(view: RepositoryServicesView) {
        self.view = view
    }

    func load() {
        view.setGithubAccessToken(token: model.githubAccessToken)
        view.setBitbucketAPIKey(apiKey: model.bitbucketAPIKey)
    }

    func setGithubAccessToken(token: String) {
        model.githubAccessToken = token
    }

    func setBitbucketAPIKey(key: String) {
        model.bitbucketAPIKey = key
    }
}
