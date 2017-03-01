//
// Created by Chope on 2017. 1. 10..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation

class GithubRepositoryServiceModel {
    var accessToken: String? {
        get {
            return UserDefaults.standard.string(forKey: keyGithubAccessToken)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: keyGithubAccessToken)
        }
    }
    var username: String? {
        get {
            return UserDefaults.standard.string(forKey: keyGithubUsername)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: keyGithubUsername)
        }
    }
    var repository: String? {
        get {
            return UserDefaults.standard.string(forKey: keyGithubRepository)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: keyGithubRepository)
        }
    }

    private let keyGithubAccessToken = "githubAccessToken"
    private let keyGithubUsername = "githubUsername"
    private let keyGithubRepository = "githubRepository"
}
