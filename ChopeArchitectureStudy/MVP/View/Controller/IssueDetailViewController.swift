//
// Created by Chope on 2017. 1. 8..
// Copyright (c) 2017 Chope. All rights reserved.
//

import UIKit
import Kingfisher
import BonMot
import Toaster

class IssueDetailViewController: UIViewController {
    var presenter: IssueDetailPresenter!
    var commentsPresenter: CommentsPresenter!

    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet fileprivate weak var bottomLayoutConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var sendButton: UIButton!
    @IBOutlet fileprivate weak var bodyTextField: UITextField!


    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200

        NotificationCenter.default.addObserver(self, selector: #selector(onChangedKeyboard(_:)), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onChangedText(_:)), name: Notification.Name.UITextFieldTextDidChange, object: nil)

        assert(presenter != nil)
        presenter.view = self
        presenter.issue()

        assert(commentsPresenter != nil)
        commentsPresenter.view = self
        commentsPresenter.comments()
    }

    @objc func onChangedKeyboard(_ notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        let keyboardInfo = userInfo.keyboardInfo()
        let hidden = keyboardInfo.endFrame.origin.y >= UIScreen.main.bounds.size.height

        UIView.animate(withDuration: keyboardInfo.duration, delay: 0, options: keyboardInfo.animationOptions, animations: {
            self.bottomLayoutConstraint.constant = hidden ? 0 : keyboardInfo.endFrame.size.height
        }, completion: nil)
    }

    @objc func onChangedText(_ notification: Notification) {
        guard let message = bodyTextField.text else { return }
        sendButton.isEnabled = message.characters.count > 5
    }

    @IBAction func onSend() {
        guard let body = bodyTextField.text else { return }
        commentsPresenter.create(body: body)
    }
}

extension IssueDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentsPresenter.count() + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "issueDetail", for: indexPath) as? IssueDetailTableViewCell else { return UITableViewCell() }
            presenter.display(view: cell)
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "comment", for: indexPath) as? CommentTableViewCell else { return UITableViewCell() }
        commentsPresenter.display(cell: cell, atIndex: indexPath.row-1)
        return cell
    }
}

extension IssueDetailViewController: UITableViewDelegate {

}

extension IssueDetailViewController: IssueDetailView {
    func set(number: Int) {
        navigationItem.title = "#\(number)"
    }

    func reload() {
        tableView.reloadData()
    }
}

extension IssueDetailViewController: CommentsView {
    func reloadComments() {
        tableView.reloadData()
    }

    func showMessage(title: String?, message: String?) {
        Toast(text: "\(title)\n\n\n\(message)", duration: Delay.long).show()
    }

}