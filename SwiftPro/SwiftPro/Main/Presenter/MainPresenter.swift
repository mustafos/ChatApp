//
//  MainMainPresenter.swift
//  SwiftPro
//
//  Created by Mustafa Bekirov on 15/01/2023.
//  Copyright © 2023 Mustafa Bekirov. All rights reserved.
//

class MainPresenter: MainModuleInput, MainViewOutput, MainInteractorOutput {

    weak var view: MainViewInput!
    var interactor: MainInteractorInput!
    var router: MainRouterInput!

    func viewIsReady() {

    }
}
