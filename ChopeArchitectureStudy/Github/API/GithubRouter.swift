//
// Created by Chope on 2017. 1. 17..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Alamofire
import XCGLogger

enum GithubRouter: URLRequestConvertible {
    case issue(user: String, repo: String, number: Int)
    case issues(user: String, repo: String)
    case createIssue(user: String, repo: String, parameters: Parameters)
    case comments(user: String, repo: String, number: Int)
    case createComment(user: String, repo: String, number: Int, parameters: Parameters)
    case nextPage(url: URL)

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
        case .nextPage:
            return .get
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
        case .nextPage(let url):
            return url.relativePath
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = try GithubRouter.baseURLString.asURL()

        var parameters: [String: Any]?
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue

        switch self {
        case .nextPage(let url):
            urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = method.rawValue
        case .createIssue(_, _, let parameters),
             .createComment(_, _, _, let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        case .issue,
             .issues,
             .comments:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
            break
        }

        if let accessToken = GithubAuthentication.sharedInstance.accessToken {
            urlRequest.setValue("token \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        return urlRequest
    }
}