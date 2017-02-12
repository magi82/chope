//
// Created by Chope on 2017. 1. 25..
// Copyright (c) 2017 Chope. All rights reserved.
//

import UIKit

protocol Item {

}

enum ItemCellType {
    case item
    case header
}

extension ItemCellType {
    func reuseIdentifier() -> String {
        switch self {
        case .header:
            return "headerCell"
        case .item:
            return "itemCell"
        }
    }
}

protocol ItemsViewControllerDelegate: class {
    func itemsViewController(_ itemsViewController: ItemsViewController, cellNibForType type: ItemCellType) -> UINib?
    func itemsViewController(_ itemsViewController: ItemsViewController, customCell cell: UITableViewCell, cellType: ItemCellType, atIndexPath indexPath: IndexPath) -> UITableViewCell
    func itemsViewController(_ itemsViewController: ItemsViewController, didSelectItem item: Item, cellType: ItemCellType, atIndexPath indexPath: IndexPath)
}

class ItemsViewController: UITableViewController {
    weak var delegate: ItemsViewControllerDelegate!
    var viewModel: ItemsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        assert(delegate != nil)
        assert(viewModel != nil)

        if let nib = delegate.itemsViewController(self, cellNibForType: .header) {
            tableView.register(nib, forCellReuseIdentifier: ItemCellType.header.reuseIdentifier())
        }
        
        if let nib = delegate.itemsViewController(self, cellNibForType: .item) {
            tableView.register(nib, forCellReuseIdentifier: ItemCellType.item.reuseIdentifier())
        } else {
            assertionFailure()
        }

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
        tableView.tableFooterView = UIView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if viewModel.numberOfItems == 0 {
            viewModel.loadFirst()
        }
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if offsetY >= (contentHeight - scrollView.frame.size.height) {
            viewModel.loadNext()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = viewModel.itemCellType(atIndex: indexPath.row)
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: type.reuseIdentifier(), for: indexPath)
        return delegate.itemsViewController(self, customCell: cell, cellType: type, atIndexPath: indexPath)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.item(atIndex: indexPath.row)
        let type = viewModel.itemCellType(atIndex: indexPath.row)
        delegate.itemsViewController(self, didSelectItem: item, cellType: type, atIndexPath: indexPath)
    }

    func reload() {
        tableView.reloadData()
    }
}