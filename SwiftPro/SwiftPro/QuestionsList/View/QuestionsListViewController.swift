//
//  QuestionsListQuestionsListViewController.swift
//  SwiftPro
//
//  Created by Mustafa Bekirov on 15/01/2023.
//  Copyright © 2023 Mustafa Bekirov. All rights reserved.
//

import UIKit

class QuestionsListViewController: UIViewController, QuestionsListViewInput {

    var output: QuestionsListViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }


    // MARK: QuestionsListViewInput
    func setupInitialState() {
    }
}
