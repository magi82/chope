//
// Created by Chope on 2017. 3. 1..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation
import CPGithub

class RepositoryServicesPresenter {
    weak var view: RepositoryServicesView! {
        didSet {
            guard let view = view else { return }

            view.set(accessToken: interactor.accessToken)
            view.set(username: interactor.username)
            view.set(repo: interactor.repository)
        }
    }
    var router: IssueRouter!
    var interactor: RepositoryServiceInteractor!

    func changed(accessToken: String) {
        interactor.accessToken = accessToken
    }

    func touchedIssues(username: String, repo: String) {
        assert(router != nil)

        interactor.username = username
        interactor.repository = repo

        let modelData: ModelData = .userAndRepo(user: username, repo: repo)
        router.routeIssues(data: modelData)
    }
}
