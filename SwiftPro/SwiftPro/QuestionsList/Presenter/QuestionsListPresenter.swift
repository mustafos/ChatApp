//
//  QuestionsListQuestionsListPresenter.swift
//  SwiftPro
//
//  Created by Mustafa Bekirov on 15/01/2023.
//  Copyright © 2023 Mustafa Bekirov. All rights reserved.
//

class QuestionsListPresenter: QuestionsListModuleInput, QuestionsListViewOutput, QuestionsListInteractorOutput {

    weak var view: QuestionsListViewInput!
    var interactor: QuestionsListInteractorInput!
    var router: QuestionsListRouterInput!

    func viewIsReady() {

    }
}
