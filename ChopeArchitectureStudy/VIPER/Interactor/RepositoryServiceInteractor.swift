//
// Created by Chope on 2017. 3. 1..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation

protocol RepositoryServiceInteractor {
    var accessToken: String? { get set }
    var username: String? { get set }
    var repository: String? { get set }
}
