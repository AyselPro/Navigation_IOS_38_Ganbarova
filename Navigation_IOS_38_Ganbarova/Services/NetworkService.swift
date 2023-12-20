//
//  NetworkService.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 06.12.2023.
//

import Foundation

enum AppConfiguration: String {
    typealias RawValue = String
    case badRequest = "https://swapi.dev/api/people/8"
    case notFound = "https://swapi.dev/api/starships/3"
    case unauthorized = "https://swapi.dev/api/planets/5"
    case users = "https://jsonplaceholder.typicode.com/todos/5"
    
    
    init(rawValue: String?) {
        guard let rawValue = rawValue else { self = .unauthorized; return }
        
        switch rawValue {
        case "https://swapi.dev/api/people/8" : self = .badRequest
        case "https://swapi.dev/api/starships/3" : self = .notFound
        default: self = .unauthorized
        }
    }
    
    
    var url: URL? {
        let string = self.rawValue
        let url = URL(string: string)
        return url
    }
}

struct NetworkService {
    
    static func request(for configuration: AppConfiguration) {
        reguest(configuration) { _, _ in }
    }
}

//MARK: - Задание 1

extension NetworkService {
    static func getUser(completion: @escaping (Data?, Error?) -> Void) {
        reguest(.users, completion: completion)
    }
}



extension NetworkService {
    private static func reguest(_ configuration: AppConfiguration, completion: @escaping (Data?, Error?) -> Void) {
        guard let url = configuration.url else { return }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse else {
                
                //с. попробуйте выключить интернет или Wi-Fi у ноутбука и запустить приложение - распечатайте error. localizedDescription или error.debugDescription
                guard let error = error else { return completion(nil, nil)}
                print("❌❌❌------------ Error -------------❌❌❌")
                print(error.localizedDescription)
                print("❌❌❌------------ end -------------❌❌❌\n\n")
                completion(nil, error)
                return
                
            }
            
            //a. data - в доступном для понимания виде, то есть String в стандартной кодировке;
            if let string = String(data: data, encoding: .utf8) {
                print("------------ Data -------------")
                print(string)
                print("------------ end -------------\n\n")
            }
            
            
            //b. свойство .allHeaderFields и .statusCode y response;
            print("------------ Headers -------------")
            print("status code: ", response.statusCode, "\n\n")
            
            for (key, value) in response.allHeaderFields {
                print(key, value)
            }
            print("------------ end -------------\n\n")
            
            completion(data, nil)
        }
        
        dataTask.resume()
    }
}
