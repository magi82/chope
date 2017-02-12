//
// Created by Chope on 2017. 1. 13..
// Copyright (c) 2017 Chope. All rights reserved.
//

import UIKit
import Toaster
import XCGLogger

class IssueCreationViewController: UIViewController {
    var viewModel: IssueCreationViewModel!

    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var bodyTextView: UITextView!
    @IBOutlet private weak var bottomLayoutConstraint: NSLayoutConstraint!

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        assert(viewModel != nil)

        bodyTextView.adjustBorder(width: CGFloat(1).px, color: UIColor(white: 0.8, alpha: 1.0))
        bodyTextView.adjustRound(radius: 5)

        NotificationCenter.default.addObserver(self, selector: #selector(onChangedKeyboard(_:)), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(addedIssue), name: Notification.Name.ViewModel.addedIssues, object: nil)
    }

    func addedIssue() {
        dismiss(animated: true)
    }

    @IBAction func onDismiss() {
        dismiss(animated: true)
    }

    @IBAction func onCreate() {
        guard let title = titleTextField.text, let body = bodyTextView.text else { return }
        viewModel.postIssue(title: title, body: body)
    }

    @objc func onChangedKeyboard(_ notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        let keyboardInfo = userInfo.keyboardInfo()
        let hidden = keyboardInfo.endFrame.origin.y >= UIScreen.main.bounds.size.height

        self.bottomLayoutConstraint.constant = hidden ? 8 : keyboardInfo.endFrame.size.height + 8

        UIView.animate(withDuration: keyboardInfo.duration, delay: 0, options: keyboardInfo.animationOptions, animations: { [weak self] in
            self?.view.layoutIfNeeded()
        }, completion: nil)
    }
}