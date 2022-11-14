//
//  DescriptionPresenter.swift
//  RickAndMorty
//
//  Created by Aleksei Omelchenko on 10/14/22.
//

import Foundation

protocol DescriptionViewProtocol: AnyObject {
    func setDescription(description: CharacterModel?)
}

protocol DescriptionViewPresenterProtocol {
    init(view: DescriptionViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, description: CharacterModel?)
    func setDescription()
}

class DetailPresenter: DescriptionViewPresenterProtocol {

    weak var view: DescriptionViewProtocol?
    var router: RouterProtocol?
    let networkService: NetworkServiceProtocol!
    var description: CharacterModel?
    
    required init(view: DescriptionViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, description: CharacterModel?) {
        self.view = view
        self.networkService = networkService
        self.description = description
        self.router = router
    }
    
    public func setDescription() {
        self.view?.setDescription(description: description)
    }
    
    
}
