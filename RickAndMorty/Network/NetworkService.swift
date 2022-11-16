//
//  NetworkService.swift
//  RickAndMorty
//
//  Created by Aleksei Omelchenko on 10/13/22.
//

import Foundation
import Alamofire

protocol NetworkServiceProtocol {
    func requestData(completion: @escaping (Result<AllChar?, Error>) -> ())
}

class NetworkService: NetworkServiceProtocol {
    var url: String? = Constants.url
    func requestData(completion: @escaping (Result<AllChar?, Error>) -> ()) {
        guard url != nil else { return }
        AF.request(url!, method: .get).validate().responseDecodable(of: AllChar.self) { [weak self] response in
            switch response.result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                self?.url = data.info.next
                completion(.success(data))
            }
        }
    }
}

