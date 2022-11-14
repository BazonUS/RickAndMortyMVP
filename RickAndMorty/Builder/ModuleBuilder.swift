//
//  ModuleBuilder.swift
//  RickAndMorty
//
//  Created by Aleksei Omelchenko on 10/13/22.
//

import Foundation
import UIKit

protocol BuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createDescriptionModule(description: CharacterModel?, router: RouterProtocol) -> UIViewController
}

class ModuleBuilder: BuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let view = MainVC()
        let networkService = NetworkService()
        let presenter = MainPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
    func createDescriptionModule(description: CharacterModel?, router: RouterProtocol) -> UIViewController {
        let view = DescriptionVC()
        let networkService = NetworkService()
        let presenter = DetailPresenter(view: view, networkService: networkService, router: router, description: description)
        view.presenter = presenter
        return view
    }

}
