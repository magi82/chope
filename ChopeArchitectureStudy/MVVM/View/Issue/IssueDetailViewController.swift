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
    @IBOutlet fileprivate weak var bottomSeparatorLayoutConstraint: NSLayoutConstraint!
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

        bottomSeparatorLayoutConstraint.constant = 1 / UIScreen.main.scale
        
        NotificationCenter.default.addObserver(self, selector: #selector(onChangedKeyboard(_:)), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onChangedText(_:)), name: Notification.Name.UITextFieldTextDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onAddedComment), name: Notification.Name.ViewModel.addedComment, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onChangedIssueDetail), name: Notification.Name.ViewModel.changedIssueDetail, object: nil)
    }

    @objc func onChangedKeyboard(_ notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        let keyboardInfo = userInfo.keyboardInfo()
        let hidden = keyboardInfo.endFrame.origin.y >= UIScreen.main.bounds.size.height

        self.bottomLayoutConstraint.constant = hidden ? 0 : keyboardInfo.endFrame.size.height

        UIView.animate(withDuration: keyboardInfo.duration, delay: 0, options: keyboardInfo.animationOptions, animations: { [weak self] in
            self?.view.layoutIfNeeded()
        }, completion: nil)
    }

    @objc func onChangedText(_ notification: Notification) {
        guard let message = bodyTextField.text else { return }
        sendButton.isEnabled = message.characters.count > 0
    }

    @objc func onAddedComment() {
        bodyTextField.resignFirstResponder()
        bodyTextField.text = nil
    }

    @objc func onChangedIssueDetail() {
        navigationItem.title = viewModel.title
    }

    @IBAction func onSend() {
        guard let body = bodyTextField.text else { return }
        viewModel.postComment(body: body)
    }
}