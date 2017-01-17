//
// Created by Chope on 2017. 1. 17..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation
import SwiftyJSON

struct PullRequest: GithubData {
    let url: URL?
    let htmlURL: URL?
    let diffURL: URL?
    let patchURL: URL?

    init(rawJson: Any) {
        let json = JSON(rawJson)
        url = json["url"].url
        htmlURL = json["html_url"].url
        diffURL = json["diff_url"].url
        patchURL = json["patch_url"].url
    }
}
