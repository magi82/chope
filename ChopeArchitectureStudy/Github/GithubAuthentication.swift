//
// Created by Chope on 2017. 1. 17..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation

class GithubAuthentication {
    static let sharedInstance = GithubAuthentication()

    var accessToken: String? {
        didSet {

        }
    }

    private init() { }
}
