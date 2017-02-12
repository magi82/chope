//
// Created by Chope on 2017. 1. 17..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Label: GithubData {
    let id: Int
    let url: URL?
    let name: String
    let color: String
    let isDefault: Bool

    init(rawJson: Any) {
        let json = JSON(rawJson)
        id = json["id"].intValue
        url = json["url"].url
        name = json["name"].stringValue
        color = json["color"].stringValue
        isDefault = json["default"].boolValue
    }
}
