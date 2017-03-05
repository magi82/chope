//
// Created by Chope on 2017. 2. 12..
// Copyright (c) 2017 Chope. All rights reserved.
//

import UIKit
import ChopeLibrary

class IssueAndCommentsViewController: ViewDataViewController {
    override func viewDidLoad() {
        nib = { cellType in
            switch cellType {
            case .item:
                return UINib(nibName: "CommentTableViewCell", bundle: nil)
            case .header:
                return UINib(nibName: "IssueDetailTableViewCell", bundle: nil)
            }
        }
        customCell = { cell, cellType, viewData, indexPath in
            if cellType == .header {
                guard let view = cell as? IssueDetailTableViewCell,
                      let viewData = viewData as? IssueViewData
                else { return }
                view.set(title: viewData.title)
                view.set(body: viewData.body)
                view.set(username: viewData.username, imageURL: viewData.userImageURL)
            }

            guard let cell = cell as? CommentTableViewCell,
                  let viewData = viewData as? CommentCellViewData
            else { return }
            cell.set(body: viewData.body)
            cell.set(username: viewData.username, imageURL: viewData.userImageURL)
            cell.onTouchedUser = {
                guard let url = viewData.userGithubURL else { return }
                UIApplication.shared.open(url)
            }
        }
        didSelect = { [weak self] _, indexPath in
            
        }

        super.viewDidLoad()
    }
}

extension IssueAndCommentsViewController: IssueAndCommentsView {

}

//class CommentsViewController: ItemsViewController {
//    var data: ModelData = .none {
//        didSet {
//            viewModel = CommentsWithIssueViewModel(data: data, issueNumber: issueNumber)
//        }
//    }
//    var issueNumber: Int = 0 {
//        didSet {
//            viewModel = CommentsWithIssueViewModel(data: data, issueNumber: issueNumber)
//        }
//    }
//
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
//
//    override func viewDidLoad() {
//        delegate = self
//
//        super.viewDidLoad()
//
//        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name.Interactor.changedComments, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name.Interactor.changedIssueDetail, object: nil)
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        if viewModel.numberOfItems == 1 {
//            viewModel.loadFirst()
//        }
//    }
//}
//
//extension CommentsViewController: ItemsViewControllerDelegate {
//    func itemsViewController(_ itemsViewController: ItemsViewController, cellNibForType type: ItemCellType) -> UINib? {
//        return type == ItemCellType.header ? UINib(nibName: "IssueDetailTableViewCell", bundle: nil) : UINib(nibName: "CommentTableViewCell", bundle: nil)
//    }
//
//    func itemsViewController(_ itemsViewController: ItemsViewController, customCell cell: UITableViewCell, cellType: ItemCellType, atIndexPath indexPath: IndexPath) -> UITableViewCell {
//        switch cellType {
//        case .header:
//            (cell as? IssueDetailTableViewCell)?.viewModel = viewModel.itemCellViewModel(atIndex: indexPath.row) as? IssueCellViewModel
//        case .item:
//            (cell as? CommentTableViewCell)?.viewModel = viewModel.itemCellViewModel(atIndex: indexPath.row) as? CommentCellViewModel
//        }
//        return cell
//    }
//
//    func itemsViewController(_ itemsViewController: ItemsViewController, didSelectItem item: Item, cellType: ItemCellType, atIndexPath indexPath: IndexPath) {
//    }
//}
