//
// Created by Chope on 2017. 3. 1..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation
import CPGithub

class GithubInteractor: RepositoryServiceInteractor {
    var model: GithubRepositoryServiceModel!

    var accessToken: String? {
        get {
            return model.accessToken
        }
        set {
            GithubAuthentication.sharedInstance.accessToken = accessToken
            model.accessToken = accessToken
        }
    }
    var username: String? {
        get {
            return model.username
        }
        set {
            model.username = username
        }
    }
    var repository: String? {
        get {
            return model.repository
        }
        set {
            model.repository = repository
        }
    }

}
