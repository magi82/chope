//
//  GithubIssuesViewController.swift
//  ChopeArchitectureStudy
//
//  Created by Chope on 2017. 1. 5..
//  Copyright (c) 2017 Chope. All rights reserved.
//

import UIKit


class GithubIssuesViewController: UIViewController {
    let model = GithubIssueModel(user: "JakeWharton", repo: "DiskLruCache")

    override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.

        model.load()

        NotificationCenter.default.addObserver(self, selector: #selector(onChangedIssues(_:)), name: GithubIssuesChangedNotification, object: nil)
    }

    func onChangedIssues(_ notification: Notification) {
        print("changed \(model.issues.count)")
    }
}
