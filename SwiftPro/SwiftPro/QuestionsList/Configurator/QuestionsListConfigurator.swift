//
//  QuestionsListQuestionsListConfigurator.swift
//  SwiftPro
//
//  Created by Mustafa Bekirov on 15/01/2023.
//  Copyright © 2023 Mustafa Bekirov. All rights reserved.
//

import UIKit

class QuestionsListModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? QuestionsListViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: QuestionsListViewController) {

        let router = QuestionsListRouter()

        let presenter = QuestionsListPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = QuestionsListInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
