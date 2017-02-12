//
// Created by Chope on 2017. 2. 8..
// Copyright (c) 2017 Chope. All rights reserved.
//

import SwiftyJSON

extension JSON {
    var date: Date? {
        guard type == .string else { return nil }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ssZ"
        return dateFormatter.date(from: stringValue)
    }
}
