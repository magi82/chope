//
// Created by Chope on 2017. 1. 13..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation

enum ModelData {
    case none
    case userAndRepo(user: String, repo: String)
    case userAndRepoWithNumber(user: String, repo: String, number: Int)
}

extension ModelData {
    func withNumber(number: Int) -> ModelData {
        switch self {
        case .userAndRepo(let user, let repo):
            return .userAndRepoWithNumber(user: user, repo: repo, number: number)
        default:
            return self
        }
    }

    var githubRepositories: GithubRepositories {
        switch self {
        case .userAndRepo(let user, let repo),
             .userAndRepoWithNumber(let user, let repo, _):
            return .repository(owner: user, repo: repo)
        default:
            return .all
        }
    }
}

protocol Model {
    var data: ModelData { get set }
}
