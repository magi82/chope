//
// Created by Chope on 2017. 1. 13..
// Copyright (c) 2017 Chope. All rights reserved.
//

import UIKit
import Toaster

class IssueCreationViewController: UIViewController {
    var viewModel: IssueCreationViewModel!

    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var bodyTextView: UITextView!

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        assert(viewModel != nil)

        NotificationCenter.default.addObserver(self, selector: #selector(addedIssue), name: Notification.Name.addedIssues, object: nil)
    }

    @IBAction func onDismiss() {
        dismiss(animated: true)
    }

    func addedIssue() {
        dismiss(animated: true)
    }

    @IBAction func onCreate() {
        guard let title = titleTextField.text, let body = bodyTextView.text else { return }
        viewModel.postIssue(title: title, body: body)
    }
}