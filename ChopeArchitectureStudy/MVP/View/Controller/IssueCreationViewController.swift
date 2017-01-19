//
// Created by Chope on 2017. 1. 13..
// Copyright (c) 2017 Chope. All rights reserved.
//

import UIKit
import Toaster

class IssueCreationViewController: UIViewController {
    var presenter: IssueCreationPresenter!

    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var bodyTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        assert(presenter != nil)
        presenter.view = self
    }

    @IBAction func onDismiss() {
        dismiss(animated: true)
    }

    @IBAction func onCreate() {
        guard let title = titleTextField.text, let body = bodyTextView.text else { return }
        presenter.create(title: title, body: body)
    }
}

extension IssueCreationViewController: IssueCreationView {
    func completeCreation() {
        self.dismiss(animated: true)
    }
}
