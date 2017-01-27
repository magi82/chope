//
// Created by Chope on 2017. 1. 25..
// Copyright (c) 2017 Chope. All rights reserved.
//

import UIKit

class ItemsPresenter<T> {
    func set(view: ItemsView) { }
    func loadFirst() { }
    func loadNext() { }
    func items() -> [T] { return [] }
}

protocol ItemsView: class {
    func set(items: [Any])
}

protocol ItemCell {
    func set(item: Any)
}

protocol ItemCellConfiguration: class {
    func custom(cell: UITableViewCell, atIndexPath indexPath: IndexPath) -> UITableViewCell
}

class ItemsViewController<T>: UITableViewController, ItemsView {
    var presenter: ItemsPresenter<T>!
    var cellNib: UINib!
    weak var cellConfiguration: ItemCellConfiguration?

    private(set) var items: [T] = []

    fileprivate let cellReuseIdentifier: String = "itemCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80

        assert(presenter != nil)
        assert(cellNib != nil)

        presenter.set(view: self)
        tableView.register(cellNib, forCellReuseIdentifier: cellReuseIdentifier)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if items.count == 0 {
            presenter.loadFirst()
        }
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if offsetY >= (contentHeight - scrollView.frame.size.height) {
            presenter.loadNext()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        let item: T = items[indexPath.row]

        if let itemCell = cell as? ItemCell {
            itemCell.set(item: item)
        }
        cellConfiguration?.custom(cell: cell, atIndexPath: indexPath)
        return cell
    }

    func set(items: [Any]) {
        guard let items = items as? [T] else { return }
        self.items = items
        tableView.reloadData()
    }
}