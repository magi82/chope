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

    func open(url: URL) {
        UIApplication.shared.open(url)
    }

    @objc func onAdd(_ barButtonItem: UIBarButtonItem) {
//        guard let navigationController: UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "createIssue") as? UINavigationController,
//              let viewController: IssueCreationViewController = navigationController.viewControllers.first as? IssueCreationViewController,
//              let presenter: IssuesViewModel = self.presenter as? IssuesViewModel
//        else { return }
//        viewController.presenter = presenter.creationPresenter()
//        present(navigationController, animated: true)
    }
}

extension IssuesViewController: ItemsViewControllerDelegate {
    func cellNib(forItemsViewController itemsViewController: ItemsViewController) -> UINib {
        return UINib(nibName: "IssueTableViewCell", bundle: nil)
    }

    func itemsViewController(_ itemsViewController: ItemsViewController, customCell cell: UITableViewCell, atIndexPath indexPath: IndexPath) -> UITableViewCell {
        guard let issueCell = cell as? IssueTableViewCell,
              let cellViewModel = viewModel.itemCellViewModel(atIndex: indexPath.row) as? IssueCellViewModel
        else { return cell }
        issueCell.viewModel = cellViewModel
        issueCell.onTouchedUser = {
        }
        return cell
    }

    func itemsViewController(_ itemsViewController: ItemsViewController, didSelectItem item: Item, atIndexPath indexPath: IndexPath) {
//        guard let viewController: IssueDetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "issueDetail") as? IssueDetailViewController,
//              let presenter: IssuesViewModel = self.presenter as? IssuesViewModel
//                else { return }
//        viewController.presenter = presenter.detailPresenter(index: indexPath.row)
//        viewController.commentsPresenter = presenter.commentsPresenter(index: indexPath.row)
//        navigationController?.pushViewController(viewController, animated: true)
    }
}