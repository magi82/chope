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

class IssuesViewController: ItemsViewController {
    private var createIssueBarButtonItem: UIBarButtonItem!

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        delegate = self

        super.viewDidLoad()

        createIssueBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAdd(_:)))
        navigationItem.rightBarButtonItem = createIssueBarButtonItem

        if let viewModel = viewModel as? IssuesViewModel {
            navigationItem.title = viewModel.title
        }

        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name.ViewModel.changedIssues, object: nil)
    }

    func open(url: URL?) {
        guard let url = url else { return }
        UIApplication.shared.open(url)
    }

    @objc func onAdd(_ barButtonItem: UIBarButtonItem) {
        guard let viewModel = viewModel as? GithubItemsViewModel else { return }
        let router = IssueRouter(navigationController: self.navigationController, viewController: self)
        router.routeCreation(data: viewModel.data)
    }
}

extension IssuesViewController: ItemsViewControllerDelegate {
    func itemsViewController(_ itemsViewController: ItemsViewController, cellNibForType type: ItemCellType) -> UINib? {
        return UINib(nibName: "IssueTableViewCell", bundle: nil)
    }

    func itemsViewController(_ itemsViewController: ItemsViewController, customCell cell: UITableViewCell, cellType: ItemCellType, atIndexPath indexPath: IndexPath) -> UITableViewCell {
        guard let issueCell = cell as? IssueTableViewCell,
              let cellViewModel = viewModel.itemCellViewModel(atIndex: indexPath.row) as? IssueCellViewModel
        else { return cell }
        issueCell.viewModel = cellViewModel
        issueCell.onTouchedUser = { [weak self] in
            self?.open(url: cellViewModel.userGithubURL)
        }
        return cell
    }

    func itemsViewController(_ itemsViewController: ItemsViewController, didSelectItem item: Item, cellType: ItemCellType, atIndexPath indexPath: IndexPath) {
        guard let issue = item as? Issue,
              let viewModel = viewModel as? GithubItemsViewModel
        else { return }
        let router = IssueRouter(navigationController: self.navigationController, viewController: self)
        router.routeDetail(data: viewModel.data, issueNumber: issue.number)
    }
}