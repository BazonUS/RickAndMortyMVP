//
//  RickAndMortyTests.swift
//  RickAndMortyTests
//
//  Created by Aleksei Omelchenko on 10/13/22.
//

import XCTest
@testable import RickAndMorty

class MockView: MainViewProtocol {
    func succes() {
    }
    
    func failure(error: Error) {
    }
}

class MockNetworkService: NetworkServiceProtocol{
    var characters: AllChar!
    
    init() {}
    
    convenience init(characters: AllChar?){
        self.init()
        self.characters = characters
    }
    func requestData(completion: @escaping (Result<RickAndMorty.AllChar?, Error>) -> ()) {
        if let characters = characters {
            completion(.success(characters))
        } else {
            let error = NSError(domain: "", code: 0)
            completion(.failure(error))
        }
    }
}

final class MainPresenterTest: XCTestCase {
    
    var view: MockView!
    var presenter: MainPresenter!
    var networkService: NetworkServiceProtocol!
    var router: RouterProtocol!
    var characters: AllChar!
    
    override func setUpWithError() throws {
        let nav = UINavigationController()
        let builder = ModuleBuilder()
        router = Router(navigationController: nav, builder: builder)
    }

    override func tearDownWithError() throws {
        view = nil
        networkService = nil
        presenter = nil
    }
    
    func testGetSuccesCharacters() {
        let character = CharacterModel(id: 1, name: "Baz", status: "Bar", species: "Bav", type: "Bat", gender: "Ban", origin: .init(name: "Bam", url: "Bax"), location: .init(name: "Baw", url: "Bas"), image: "Bad", episode: ["Bak", "Bal"], url: "Bap", created: "Baf")
        let info = Info(count: 12, pages: 122, next: "Baz", prev: "Bar")
        let characters = AllChar(info: info, results: [character])
        view = MockView()
        networkService = MockNetworkService(characters: characters)
        presenter = MainPresenter(view: view, networkService: networkService, router: router)
        
        var catchCharacters: AllChar?
        
        networkService.requestData { result in
            switch result {
            case .success(let characters):
                catchCharacters = characters
            case .failure(let error):
                print(error)
            }
        }
        XCTAssertNotEqual(catchCharacters?.results.count, 0)
        XCTAssertEqual(catchCharacters?.results.count, characters.results.count)
        
    }
    
    func testGetFailureCharacters() {
        let character = CharacterModel(id: 1, name: "Baz", status: "Bar", species: "Bav", type: "Bat", gender: "Ban", origin: .init(name: "Bam", url: "Bax"), location: .init(name: "Baw", url: "Bas"), image: "Bad", episode: ["Bak", "Bal"], url: "Bap", created: "Baf")
        let info = Info(count: 12, pages: 122, next: "Baz", prev: "Bar")
        view = MockView()
        networkService = MockNetworkService()
        presenter = MainPresenter(view: view, networkService: networkService, router: router)
        
        var catchError: Error?
        
        networkService.requestData { result in
            switch result {
            case .success(let characters):
                print(characters!)
            case .failure(let error):
                catchError = error
            }
        }
        XCTAssertNotNil(catchError)
    }
}
