//
//  Router.swift
//  RickAndMorty
//
//  Created by Aleksei Omelchenko on 10/14/22.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var builder: BuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showDescription(description: CharacterModel?)
}

class Router: RouterProtocol {
    var navigationController: UINavigationController?
    var builder: BuilderProtocol?
    
    init(navigationController: UINavigationController, builder: BuilderProtocol) {
        self.navigationController = navigationController
        self.builder = builder
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let mainVC = builder?.createMainModule(router: self) else { return }
            navigationController.viewControllers = [mainVC]
        }
    }
    
    func showDescription(description: CharacterModel?) {
        if let navigationController = navigationController {
            guard let descriptionVC = builder?.createDescriptionModule(description: description, router: self) else { return }
            navigationController.pushViewController(descriptionVC, animated: true)
        }
    }
}
