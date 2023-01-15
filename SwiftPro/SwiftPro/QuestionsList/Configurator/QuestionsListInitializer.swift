//
//  QuestionsListQuestionsListInitializer.swift
//  SwiftPro
//
//  Created by Mustafa Bekirov on 15/01/2023.
//  Copyright © 2023 Mustafa Bekirov. All rights reserved.
//

import UIKit

class QuestionsListModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var questionslistViewController: QuestionsListViewController!

    override func awakeFromNib() {

        let configurator = QuestionsListModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: questionslistViewController)
    }

}
