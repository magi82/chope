//
//  IssuesViewController.swift
//  ChopeArchitectureStudy
//
//  Created by Chope on 2017. 1. 5..
//  Copyright (c) 2017 Chope. All rights reserved.
//

import UIKit
import CPGithub
import ChopeLibrary

class IssuesViewController: ViewDataViewController {
    override func viewDidLoad() {
        nib = { cellType in
            switch cellType {
            case .item:
                return UINib(nibName: "IssueTableViewCell", bundle: nil)
            case .header:
                return nil
            }
        }
        customCell = { cell, viewData, indexPath in
            guard let cell = cell as? IssueTableViewCell,
                  let viewData = viewData as? IssueCellViewData
            else { return }
            cell.set(number: viewData.number, title: viewData.title)
            cell.set(username: viewData.username, imageURL: viewData.userImageURL)
            cell.set(numberOfComments: viewData.countOfComments)
            cell.onTouchedUser = {
                guard let url = viewData.userGithubURL else { return }
                UIApplication.shared.open(url)
            }
        }
        didSelect = { [weak self] _, indexPath in
            guard let presenter = self?.presenter as? IssuesPresenter else { return }
            presenter.touchIssue(index: indexPath.row)
        }

        presenter.view = self

        super.viewDidLoad()
    }

}

extension IssuesViewController: IssuesView {
    func set(title: String) {
        self.title = title
    }
}

//class IssuesViewController: ItemsViewController {
//    var presenter: IssuesPresenter!
//
//    fileprivate var issues: [IssueCellViewData] = []
//
//    private var createIssueBarButtonItem: UIBarButtonItem!
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
//        createIssueBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAdd(_:)))
//        navigationItem.rightBarButtonItem = createIssueBarButtonItem
//    }
//
//    func open(url: URL?) {
//        guard let url = url else { return }
//        UIApplication.shared.open(url)
//    }
//
//    @objc func onAdd(_ barButtonItem: UIBarButtonItem) {
//        guard let navigationController = navigationController, let viewModel = viewModel as? GithubItemsViewModel else { return }
//        let router = IssueRouter(navigationController: navigationController)
//        router.routeCreation(data: viewModel.data)
//    }
//}
//
//extension IssuesViewController: ItemsViewControllerDelegate {
//    func itemsViewController(_ itemsViewController: ItemsViewController, cellNibForType type: ItemCellType) -> UINib? {
//        return UINib(nibName: "IssueTableViewCell", bundle: nil)
//    }
//
//    func itemsViewController(_ itemsViewController: ItemsViewController, customCell cell: UITableViewCell, cellType: ItemCellType, atIndexPath indexPath: IndexPath) -> UITableViewCell {
//        guard let issueCell = cell as? IssueTableViewCell else { return cell }
//        let viewData = issues[indexPath.row]
//        issueCell.onTouchedUser = { [weak self] in
//            self?.open(url: viewData.userGithubURL)
//        }
//        return cell
//    }
//
//    func itemsViewController(_ itemsViewController: ItemsViewController, didSelectItem item: Item, cellType: ItemCellType, atIndexPath indexPath: IndexPath) {
//        guard let issue = item as? Issue,
//              let viewModel = viewModel as? GithubItemsViewModel,
//              let navigationController = navigationController
//        else { return }
//        let router = IssueRouter(navigationController: navigationController)
//        router.routeDetail(data: viewModel.data, issueNumber: issue.number)
//    }
//}
//
//extension IssuesViewController: IssuesView {
//    func set(title: String) {
//        self.title = title
//    }
//
//    func set(issues: [IssueCellViewData]) {
//        self.issues = issues
//    }
//}