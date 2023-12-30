//
//  PostService.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 28.12.2023.
//

import Foundation

protocol IPostService {
    var toDoItems: [ToDoList] { get }
    func  createToDoModel(title: String, author: String, image: String, likes: Int16, views: Int16)
    func deleteToDoList(at index: Int)
    
}
final class PostService {
    
    private(set) var toDoItems = [ToDoList]()
    private let postListService: IPostListService = PostListService.shared
    
    init() {
        fetchToDoList()
    }
    
    private func fetchToDoList() {
        let request = ToDoList.fetchRequest()
        do {
            toDoItems = try postListService.context.fetch(request)
        } catch {
            print(error)
        }
    }
    
    func createToDoModel(title: String, author: String, image: String, likes: Int16, views: Int16) {
        let newToDoList = ToDoList(context: postListService.context)
        newToDoList.title = title
        newToDoList.author = author
        newToDoList.image = image
        newToDoList.likes = likes
        newToDoList.views = views
        postListService.saveContext()
        fetchToDoList()
    }
    
    func deleteToDoList(at index: Int) {
        postListService.context.delete(toDoItems[index])
        postListService.saveContext()
        fetchToDoList()
    }
}
 
