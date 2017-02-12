//
// Created by Chope on 2017. 1. 8..
// Copyright (c) 2017 Chope. All rights reserved.
//

import UIKit
import Kingfisher
import BonMot
import Toaster

class IssueDetailViewController: UIViewController {
    var viewModel: CommentsWithIssueViewModel! {
        didSet {
            commentsViewController.viewModel = viewModel
        }
    }

    @IBOutlet fileprivate weak var containerView: UIView!
    @IBOutlet fileprivate weak var bottomLayoutConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var sendButton: UIButton!
    @IBOutlet fileprivate weak var bodyTextField: UITextField!

    fileprivate var commentsViewController = CommentsViewController()

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildViewController(commentsViewController)
        containerView.addSubview(commentsViewController.view)
        commentsViewController.view.frame = containerView.bounds
        commentsViewController.didMove(toParentViewController: self)
        containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[view]-|", metrics: nil, views: ["view": commentsViewController.view]))
        containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[view]-|", metrics: nil, views: ["view": commentsViewController.view]))
        containerView.setNeedsLayout()
        containerView.layoutIfNeeded()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onChangedKeyboard(_:)), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onChangedText(_:)), name: Notification.Name.UITextFieldTextDidChange, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)


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
        sendButton.isEnabled = message.characters.count > 0
    }

    @IBAction func onSend() {
        guard let body = bodyTextField.text else { return }
        viewModel.postComment(body: body)
    }
}

//extension IssueDetailViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        guard issue != nil else {
//            return comments.count
//        }
//        return comments.count + 1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if issue != nil && indexPath.row == 0 {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "issueDetail", for: indexPath) as? IssueDetailTableViewCell else { return UITableViewCell() }
//            cell.set(issue: issue)
//            return cell
//        }
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "comment", for: indexPath) as? CommentTableViewCell else { return UITableViewCell() }
//        let index = issue != nil ? indexPath.row - 1 : indexPath.row
//        let comment: Comment = comments[index]
////        cell.set(comment: comment)
//        return cell
//    }
//}
//
//extension IssueDetailViewController: UITableViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let offsetY = scrollView.contentOffset.y
//        let contentHeight = scrollView.contentSize.height
//
//        if offsetY >= (contentHeight - scrollView.frame.size.height) {
//            commentsPresenter.nextComments()
//        }
//    }
//}
//
//extension IssueDetailViewController: IssueDetailView {
//    func set(issue: Issue) {
//        navigationItem.title = "#\(issue.number)"
//        self.issue = issue
//        tableView.reloadData()
//    }
//}
//
//extension IssueDetailViewController: CommentsView {
//    func set(comments: [Comment]) {
//        self.comments = comments
//        tableView.reloadData()
//    }
//
//    func clearInputText() {
//        bodyTextField.text = nil
//        sendButton.isEnabled = false
//        bodyTextField.resignFirstResponder()
//    }
//}