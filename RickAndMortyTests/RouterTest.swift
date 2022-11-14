//
//  RouterTest.swift
//  RickAndMortyTests
//
//  Created by Aleksei Omelchenko on 10/16/22.
//

import XCTest
@testable import RickAndMorty

class MockNavigationController: UINavigationController {
    var presentedVC: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        self.presentedVC = viewController
        super.pushViewController(viewController, animated: animated)
    }
}

final class RouterTest: XCTestCase {
    
    var router: RouterProtocol!
    var navigationController = MockNavigationController()
    let builder = ModuleBuilder()

    override func setUpWithError() throws {
        router = Router(navigationController: navigationController, builder: builder)
    }

    override func tearDownWithError() throws {
        router = nil
    }

    func testRouter() {
        router.showDescription(description: nil)
        let descriptionVC = navigationController.presentedVC
        XCTAssertTrue(descriptionVC is DescriptionVC)
    }
}
