//
//  PostService.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 28.12.2023.
//

import Foundation

protocol IPostService {
    var toDoItems: [ToDoList] { get }
    func  createToDoModel(title: String, author: String, image: String, likes: Int16, views: Int16, descriptionn: String, dateCreated: Date)
    func deleteToDoList(at index: Int)
    
}
final class PostService {
    
    private(set) var toDoItems = [ToDoList]()
    private let postDataService: IPostDataService = PostDataService.shared
    
    init() {
        fetchToDoList()
    }
    
    private func fetchToDoList() {
        let request = ToDoList.fetchRequest()
        do {
            toDoItems = try postDataService.context.fetch(request)
        } catch {
            print(error)
        }
    }
    
    func  createToDoModel(title: String, author: String, image: String, likes: Int16, views: Int16, descriptionn: String, dateCreated: Date) {
            let newToDoModel = ToDoList(context: postDataService.context)
            newToDoModel.title = title
            newToDoModel.author = author
            newToDoModel.descriptionn = descriptionn
            newToDoModel.image = image
            newToDoModel.likes = likes
            newToDoModel.views = views
            newToDoModel.dateCreated = Date()
        postDataService.saveContext()
            fetchToDoList()
        }
        
        //    func update(at index: Int) {
        //        let currentModelToUpdate = toDoItems[index]
        //        currentModelToUpdate.title = "Новое название"
        //        postDataService.saveContext()
        //        fetchToDoList()
        //    }
        
        func deleteToDoModel(at index: Int) {
            postDataService.context.delete(toDoItems[index])
            postDataService.saveContext()
            fetchToDoList()
        }
    }
