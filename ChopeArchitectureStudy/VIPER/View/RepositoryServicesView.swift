//
// Created by Chope on 2017. 3. 1..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation

protocol RepositoryServicesView: class {
    func set(accessToken: String?)
    func set(username: String?)
    func set(repo: String?)
}
