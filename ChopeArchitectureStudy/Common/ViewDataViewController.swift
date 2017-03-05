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
    func set(headerData: ViewData?)
}

class ViewDataViewController: UITableViewController {
    var presenter: ViewDataPresenter!
    var nib: ((ViewDataCellType) -> UINib?)?
    var customCell: ((UITableViewCell, ViewDataCellType, ViewData, IndexPath) -> Void)?
    var didSelect: ((ViewData, IndexPath) -> Void)?

    fileprivate var data: [ViewData] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    fileprivate var headerData: ViewData? {
        didSet {
            tableView.reloadData()
        }
    }
    fileprivate var hasHeader: Bool = false

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
            tableView.register(nib, forCellReuseIdentifier: headerCellIdentifier)
            hasHeader = true
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
        if hasHeader {
            return data.count + 1
        }
        return data.count
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 && hasHeader {
            let cell = tableView.dequeueReusableCell(withIdentifier: headerCellIdentifier, for: indexPath)
            if let headerData = headerData {
                self.customCell?(cell, .header, headerData, indexPath)
            }
            return cell
        }
        let index = indexPath.row - (hasHeader ? 1 : 0)
        let cell = tableView.dequeueReusableCell(withIdentifier: itemCellIdentifier, for: indexPath)
        let viewData = data[index]
        self.customCell?(cell, .item, viewData, indexPath)
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

    func set(headerData: ViewData?) {
        self.headerData = headerData
    }
}