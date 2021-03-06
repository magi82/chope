//
// Created by Chope on 2017. 3. 5..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation

protocol CommentsInteractor: PaginationInteractor {
    var comments: [CommentCellViewData] { get set }
    var modelData: ModelData { get set }
}
