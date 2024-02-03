//
//  JokeNetworkService.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 30.12.2023.
//

import Foundation

enum JokeNetworkError: Error {
    case urlNotCreated
    case unknownUrlSession
}

protocol JokeNetworkService {
    func loadJoke(completion: @escaping ((Result<JokeResponse, Error>) -> Void))
}

final class JokeNetworkServiceImpl: JokeNetworkService {
    
    func loadJoke(completion: @escaping ((Result<JokeResponse, Error>) -> Void)) {
        guard let url = URL(string: "https://api.chucknorris.io/jokes/random")
        else {
            return completion(.failure(JokeNetworkError.urlNotCreated))
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                guard let error = error else {
                    return completion(.failure(JokeNetworkError.unknownUrlSession))
                }
                return completion(.failure(error))
            }
            
            do {
                let response = try JSONDecoder().decode(JokeResponse.self, from: data)
                return completion(.success(response))
            } catch {
                return completion(.failure(error))
            }
        }
        dataTask.resume()
    }
}
