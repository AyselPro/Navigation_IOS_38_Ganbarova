//
//  JokeStorageService.swift
//  Navigation_IOS_38...
//
//  Created by Nikita Sosyuk on 30.12.2023.
//

import Foundation
import RealmSwift

protocol JokeStorageService {
    // Теперь нужны только категории.
    func fetchCategories() -> [String]
    func fetchModelsSortedByTime() -> [JokeModel]
    // Теперь нужно получать шутки для определенной категории.
    func fetchModels(category: String) -> [JokeModel]
    func save(from response: JokeResponse) -> Bool
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
    
    func fetchCategories() -> [String] {
        guard let realm = try? Realm() else { return [] }
        
        let objects = realm.objects(JokeModel.self)
        
        // Создаем сет (уникальные значения) из категорий
        var categorySet: Set<String> = []
        objects.forEach { object in
            // Если категорий у объекта нет, то добавляем строчку с пустой категорией.
            guard !object.categories.isEmpty else {
                categorySet.insert(.emptyCategory)
                return
            }
            
            // Если категории есть, то добавляем их в сет, чтобы в итоге получить все уникальные категории.
            object.categories.forEach {
                categorySet.insert($0)
            }
        }
        
        return Array(categorySet)
    }
    
    func fetchModels(category: String) -> [JokeModel] {
        guard let realm = try? Realm() else { return [] }
        
        let objects = realm.objects(JokeModel.self)
        
        // Если категория пуста (without category 🧐), то ищем все объекты с пусты массивом категорий.
        if category == .emptyCategory {
            return objects.filter { $0.categories.isEmpty }
        } else {
            // Если категория есть, то ищем все объекты с нужной категорией в массиве категорий.
            return objects.filter { $0.categories.contains(category) }
        }
    }
}

private extension String {
    static let emptyCategory = "without category 🧐"
}
