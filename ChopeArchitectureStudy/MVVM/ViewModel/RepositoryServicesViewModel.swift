//
// Created by Chope on 2017. 2. 12..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation

class RepositoryServicesViewModel {
    var accessTokenForGithub: String? {
        get {
            return RepositoryServicesModel().githubAccessToken
        }
        set {
            RepositoryServicesModel().githubAccessToken = newValue
        }
    }
}
