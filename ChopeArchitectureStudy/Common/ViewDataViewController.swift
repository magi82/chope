//
// Created by Chope on 2017. 3. 5..
// Copyright (c) 2017 Chope. All rights reserved.
//

import UIKit

enum ViewDataCellType {
    case header
    case item
}

protocol ViewData {

}

protocol ViewDataPresenter {
    weak var view: ImplicitlyUnwrappedOptional<ViewDataView> { get set }

    func requestFirstPage()
    func requestNextPage()
}

protocol ViewDataView: class {
    func set(data: [ViewData])
}

class ViewDataViewController: UITableViewController {
    var presenter: ViewDataPresenter!
    var nib: ((ViewDataCellType) -> UINib?)?
    var customCell: ((UITableViewCell, ViewData, IndexPath) -> Void)?
    var customHeader: ((UITableViewHeaderFooterView) -> Void)?
    var didSelect: ((ViewData, IndexPath) -> Void)?

    fileprivate var data: [ViewData] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    private let headerCellIdentifier = "header"
    private let itemCellIdentifier = "item"

    override func viewDidLoad() {
        super.viewDidLoad()

        assert(presenter != nil)

        let refreshControl = UIRefreshControl()
        self.refreshControl = refreshControl

        tableView.addSubview(refreshControl)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
        tableView.tableFooterView = UIView()

        refreshControl.addTarget(self, action: #selector(onPullToRefresh), for: .valueChanged)

        if let nib = nib?(.header) {
            tableView.register(nib, forHeaderFooterViewReuseIdentifier: headerCellIdentifier)
        }

        guard let nib = nib?(.item) else { return }
        tableView.register(nib, forCellReuseIdentifier: itemCellIdentifier)

        presenter.view = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if data.count == 0 {
            presenter.requestFirstPage()
        }
    }

    @objc func onPullToRefresh() {
        presenter.requestFirstPage()
    }

    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    public override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerCellIdentifier) else { return nil }
        self.customHeader?(headerView)
        return headerView
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: itemCellIdentifier, for: indexPath)
        let viewData = data[indexPath.row]
        self.customCell?(cell, viewData, indexPath)
        return cell
    }

    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewData = data[indexPath.row]
        self.didSelect?(viewData, indexPath)
    }

    public override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if offsetY >= (contentHeight - scrollView.frame.size.height) {
            presenter.requestNextPage()
        }
    }
}

extension ViewDataViewController: ViewDataView {
    func set(data: [ViewData]) {
        self.data = data
        refreshControl?.endRefreshing()
    }
}