//
// Created by Chope on 2017. 3. 1..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation

protocol RepositoryIssuesInteractor {
    var title: String { get set }
    var issues: [IssueCellViewData] { get set }
    var modelData: ModelData { get set }

    func requestFirstPageIssues()
    func requestNextPageIssues()
}
