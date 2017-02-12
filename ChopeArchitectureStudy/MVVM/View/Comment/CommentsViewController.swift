//
// Created by Chope on 2017. 2. 12..
// Copyright (c) 2017 Chope. All rights reserved.
//

import UIKit

class CommentsViewController: ItemsViewController {
    var data: ModelData = .none {
        didSet {
            viewModel = CommentsWithIssueViewModel(data: data, issueNumber: issueNumber)
        }
    }
    var issueNumber: Int = 0 {
        didSet {
            viewModel = CommentsWithIssueViewModel(data: data, issueNumber: issueNumber)
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        delegate = self

        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name.changedComments, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name.changedIssueDetail, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if viewModel.numberOfItems == 1 {
            viewModel.loadFirst()
        }
    }
}

extension CommentsViewController: ItemsViewControllerDelegate {
    func itemsViewController(_ itemsViewController: ItemsViewController, cellNibForType type: ItemCellType) -> UINib? {
        return type == ItemCellType.header ? UINib(nibName: "IssueDetailTableViewCell", bundle: nil) : UINib(nibName: "CommentTableViewCell", bundle: nil)
    }

    func itemsViewController(_ itemsViewController: ItemsViewController, customCell cell: UITableViewCell, cellType: ItemCellType, atIndexPath indexPath: IndexPath) -> UITableViewCell {
        switch cellType {
        case .header:
            (cell as? IssueDetailTableViewCell)?.viewModel = viewModel.itemCellViewModel(atIndex: indexPath.row) as? IssueCellViewModel
        case .item:
            (cell as? CommentTableViewCell)?.viewModel = viewModel.itemCellViewModel(atIndex: indexPath.row) as? CommentCellViewModel
        }
        return cell
    }

    func itemsViewController(_ itemsViewController: ItemsViewController, didSelectItem item: Item, cellType: ItemCellType, atIndexPath indexPath: IndexPath) {
    }
}
