//
// Created by Chope on 2017. 1. 25..
// Copyright (c) 2017 Chope. All rights reserved.
//

import UIKit

protocol Item {

}

protocol ItemsViewModel {
    // value
    var numberOfItems: Int { get }
    func itemCellViewModel(atIndex index: Int) -> ItemCellViewModel
    func item(atIndex index: Int) -> Item

    // action
    func loadFirst()
    func loadNext()
}

protocol ItemCellViewModel: class {
    
}

protocol ItemsViewControllerDelegate: class {
    func cellNib(forItemsViewController itemsViewController: ItemsViewController) -> UINib
    func itemsViewController(_ itemsViewController: ItemsViewController, customCell cell: UITableViewCell, atIndexPath indexPath: IndexPath) -> UITableViewCell
    func itemsViewController(_ itemsViewController: ItemsViewController, didSelectItem item: Item, atIndexPath indexPath: IndexPath)
}

class ItemsViewController: UITableViewController {
    weak var delegate: ItemsViewControllerDelegate!
    var viewModel: ItemsViewModel!

    fileprivate let cellReuseIdentifier: String = "itemCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        assert(delegate != nil)
        assert(viewModel != nil)

        let cellNib = delegate.cellNib(forItemsViewController: self)
        tableView.register(cellNib, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
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
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        return delegate.itemsViewController(self, customCell: cell, atIndexPath: indexPath)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.item(atIndex: indexPath.row)
        delegate.itemsViewController(self, didSelectItem: item, atIndexPath: indexPath)
    }

    func reload() {
        tableView.reloadData()
    }
}