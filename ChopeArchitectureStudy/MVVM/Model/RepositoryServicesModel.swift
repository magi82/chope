//
// Created by Chope on 2017. 1. 10..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation

class RepositoryServicesModel {
    var githubAccessToken: String? {
        get {
            return UserDefaults.standard.string(forKey: keyGithubAccessToken)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: keyGithubAccessToken)
        }
    }

    private let keyGithubAccessToken = "githubAccessToken"
}
