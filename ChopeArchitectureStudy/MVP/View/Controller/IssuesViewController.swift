//
//  IssuesViewController.swift
//  ChopeArchitectureStudy
//
//  Created by Chope on 2017. 1. 5..
//  Copyright (c) 2017 Chope. All rights reserved.
//

import UIKit

class IssuesViewController: ItemsViewController<Issue>, IssuesView, ItemCellConfiguration {
    var model: IssuesModel! {
        didSet {
            guard let model = model else { return }
            presenter = IssuesPresenter(model: model)
        }
    }

    private var createIssueBarButtonItem: UIBarButtonItem!

    override func loadView() {
        super.loadView()

        cellNib = UINib(nibName: "IssueTableViewCell", bundle: nil)
        cellConfiguration = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        createIssueBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAdd(_:)))
        navigationItem.rightBarButtonItem = createIssueBarButtonItem
    }

    func open(url: URL) {
        UIApplication.shared.open(url)
    }

    func custom(cell: UITableViewCell, atIndexPath indexPath: IndexPath) -> UITableViewCell {
        guard let issueCell = cell as? IssueTableViewCell, let presenter = self.presenter as? IssuesPresenter else { return cell }
        issueCell.onTouchedUser = {
            presenter.touchUserPhoto(atIndex: indexPath.row)
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]

        guard let viewController: IssueDetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "issueDetail") as? IssueDetailViewController,
              let presenter: IssuesPresenter = self.presenter as? IssuesPresenter
        else { return }
        viewController.presenter = presenter.detailPresenter(index: indexPath.row)
        viewController.commentsPresenter = presenter.commentsPresenter(index: indexPath.row)
        navigationController?.pushViewController(viewController, animated: true)
    }

    @objc func onAdd(_ barButtonItem: UIBarButtonItem) {
        guard let navigationController: UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "createIssue") as? UINavigationController,
              let viewController: IssueCreationViewController = navigationController.viewControllers.first as? IssueCreationViewController,
              let presenter: IssuesPresenter = self.presenter as? IssuesPresenter
        else { return }
        viewController.presenter = presenter.creationPresenter()
        present(navigationController, animated: true)
    }
}