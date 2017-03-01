//
// Created by Chope on 2017. 2. 12..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation

class RepositoryServicesViewModel {
    var accessTokenForGithub: String? {
        get {
            return GithubRepositoryServiceModel().accessToken
        }
        set {
            GithubRepositoryServiceModel().accessToken = newValue
        }
    }
}
