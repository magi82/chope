//
//  IssuesViewController.swift
//  ChopeArchitectureStudy
//
//  Created by Chope on 2017. 1. 5..
//  Copyright (c) 2017 Chope. All rights reserved.
//

import UIKit

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

        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name.changedIssues, object: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        guard segue.identifier == "createIssue",
              let navigationController = segue.destination as? UINavigationController,
              let viewController = navigationController.viewControllers.first as? IssueCreationViewController,
              let viewModel = sender as? IssueCreationViewModel
        else { return }

        viewController.viewModel = viewModel
    }

    func open(url: URL) {
        UIApplication.shared.open(url)
    }

    @objc func onAdd(_ barButtonItem: UIBarButtonItem) {
        guard let navigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "createIssue") as? UINavigationController,
              let viewController = navigationController.viewControllers.first as? IssueCreationViewController
        else { return }
        viewController.viewModel = IssueCreationViewModel(data: viewModel.data)
        present(navigationController, animated: true)
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
        issueCell.onTouchedUser = {
        }
        return cell
    }

    func itemsViewController(_ itemsViewController: ItemsViewController, didSelectItem item: Item, cellType: ItemCellType, atIndexPath indexPath: IndexPath) {
        guard let viewController: IssueDetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "issueDetail") as? IssueDetailViewController,
              let issue = item as? Issue
        else { return }
        viewController.viewModel = CommentsWithIssueViewModel(data: viewModel.data, issueNumber: issue.number)
        navigationController?.pushViewController(viewController, animated: true)
    }
}