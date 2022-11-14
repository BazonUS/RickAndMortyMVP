//
//  Presenter.swift
//  RickAndMorty
//
//  Created by Aleksei Omelchenko on 10/13/22.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    func success(with characters: [CharacterModel])
    func failure(error: Error)
}

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    func requestData()
    var characters: [CharacterModel]? {get set}
    func tapOnTheCharacter(character: CharacterModel?)
}

class MainPresenter: MainViewPresenterProtocol {
    
    weak var view: MainViewProtocol?
    var router: RouterProtocol?
    let networkService: NetworkServiceProtocol?
    var characters: [CharacterModel]? = []
    var isChangesStates: Bool = false

    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        requestData()
    }
    
    func requestData() {
        networkService?.requestData { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let characters):
                    guard let characters = characters else { return }
                    self.characters?.append(contentsOf: characters.results)
                    if let chars = self.characters {
                        self.view?.success(with: chars)
                    }
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
    
    func tapOnTheCharacter(character: CharacterModel?) {
        router?.showDescription(description: character)
    }
}
