//
// Created by Chope on 2017. 1. 5..
// Copyright (c) 2017 Chope. All rights reserved.
//

import SwiftyJSON

class Issue {
    var id: String = ""
    var number: Int = 0
    var title: String = ""
    var body: String = ""
    var comments: Int?

    var user: User?
}
