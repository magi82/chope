//
// Created by Chope on 2017. 1. 17..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Alamofire

enum GithubRouter: URLRequestConvertible {
    case issue(user: String, repo: String, number: Int)
    case issues(user: String, repo: String)
    case createIssue(user: String, repo: String, parameters: Parameters)
    case comments(user: String, repo: String, number: Int)
    case createComment(user: String, repo: String, number: Int, parameters: Parameters)

    static let baseURLString = "https://api.github.com"

    var method: HTTPMethod {
        switch self {
        case .issues:
            return .get
        case .issue:
            return .get
        case .createIssue:
            return .post
        case .comments:
            return .get
        case .createComment:
            return .post
        }
    }

    var path: String {
        switch self {
        case .issue(let user, let repo, let number):
            return "/repos/\(user)/\(repo)/issues/\(number)"
        case .issues(let user, let repo),
             .createIssue(let user, let repo, _):
            return "/repos/\(user)/\(repo)/issues"
        case .comments(let user, let repo, let number),
             .createComment(let user, let repo, let number, _):
            return "/repos/\(user)/\(repo)/issues/\(number)/comments"
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = try GithubRouter.baseURLString.asURL()

        var parameters: [String: Any]?
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue

        switch self {
        case .issue,
             .issues,
             .comments:
            break
        case .createIssue(_, _, let params):
            parameters = params
        case .createComment(_, _, _, let params):
            parameters = params
        }

        urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        return urlRequest
    }
}