//
//  JokeStorageService.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 30.12.2023.
//


import Foundation
import RealmSwift

protocol JokeStorageService {
    func save(from response: JokeResponse) -> Bool
    func fetchModelsSortedByTime() -> [JokeModel]
    func fetchModelsByCategories() -> [(String, [JokeModel])]
}

final class JokeStorageServiceImpl: JokeStorageService {
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-dd-MM HH:mm:ss.SSSSSS"
        return formatter
    }()
    
    init() {
        let configuration = Realm.Configuration(schemaVersion: 2)
        Realm.Configuration.defaultConfiguration = configuration
    }
    
    func save(from response: JokeResponse) -> Bool {
        guard let realm = try? Realm() else { return false }
        
        let model = JokeModel()
        model.id = response.id
        model.value = response.value
        model.createdAt = dateFormatter.date(from: response.createdAt) ?? Date()
        model.categories.append(objectsIn: Set(response.categories))
        
        do {
            try realm.write {
                realm.create(JokeModel.self, value: model, update: .all)
            }
            return true
        } catch {
            return false
        }
    }
    
    func fetchModelsSortedByTime() -> [JokeModel] {
        guard let realm = try? Realm() else { return [] }
        
        return realm.objects(JokeModel.self).sorted(by: \.createdAt, ascending: false).map { $0 }
    }
    
    func fetchModelsByCategories() -> [(String, [JokeModel])] {
        guard let realm = try? Realm() else { return [] }
        var result: [(String, [JokeModel])] = []
        
        var categorySet: Set<String> = []
        realm.objects(JokeModel.self).forEach { object in
            object.categories.forEach {
                categorySet.insert($0)
            }
        }
        for category in categorySet {
            let objects = realm.objects(JokeModel.self).filter { $0.categories.contains(category) }
            result.append((category, Array(objects)))
        }
        
        return result
    }
}
