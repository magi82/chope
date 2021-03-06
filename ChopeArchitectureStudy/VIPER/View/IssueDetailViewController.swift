//
// Created by Chope on 2017. 1. 8..
// Copyright (c) 2017 Chope. All rights reserved.
//

import UIKit
import Kingfisher
import BonMot
import Toaster
import ChopeLibrary


class IssueDetailViewController: UIViewController {
    var presenter: IssueDetailPresenter!
    var issueAndCommentsViewController: IssueAndCommentsViewController!

    @IBOutlet fileprivate weak var containerView: UIView!
    @IBOutlet fileprivate weak var bottomLayoutConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var bottomSeparatorView: UIView!
    @IBOutlet fileprivate weak var bottomSeparatorLayoutConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var sendButton: UIButton!
    @IBOutlet fileprivate weak var bodyTextField: UITextField!

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        assert(issueAndCommentsViewController != nil)
        addChild(viewController: issueAndCommentsViewController, in: containerView)

        bottomSeparatorLayoutConstraint.constant = CGFloat(1).px
        bottomSeparatorView.backgroundColor = UIColor.textFieldBorderColor

        bodyTextField.adjustTextFieldBorderStyle()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onChangedKeyboard(_:)), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onChangedText(_:)), name: Notification.Name.UITextFieldTextDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onAddedComment), name: Notification.Name.Interactor.addedComment, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onChangedIssueDetail), name: Notification.Name.Interactor.changedIssue, object: nil)
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
//        navigationItem.title = viewModel.title
    }

    @IBAction func onSend() {
        guard let body = bodyTextField.text else { return }
//        viewModel.postComment(body: body)
    }
}

extension IssueDetailViewController: IssueDetailView {
    func set(title: String) {
        self.title = title
    }
}