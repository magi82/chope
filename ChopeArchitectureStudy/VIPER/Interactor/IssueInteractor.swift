//
// Created by Chope on 2017. 3. 5..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation

protocol IssueInteractor {
    var modelData: ModelData { get set }
    var issue: IssueViewData { get set }

    func request()
}
