//
//  ItemService.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 03.01.2024.
//

import CoreData

protocol IPostService {
    func fetchPosts() -> [PostModel]
    
    func savePost(_ model: Post)
    func deletePost(id: String)
    func containsPost(id: String) -> Bool
}

final class PostService: IPostService {
    
    private var posts = [PostModel]()
    private let coreDataService: ICoreDataService
    
    init(coreDataService: ICoreDataService) {
        self.coreDataService = coreDataService
    }
    
    func fetchPosts() -> [PostModel] {
        let request = PostModel.fetchRequest()
        
        do {
            posts = try coreDataService.context.fetch(request)
        } catch {
            print(error)
            posts = []
        }
        
        return posts
    }
    
    func savePost(_ model: Post) {
        let context = coreDataService.context
        
        let postModel = PostModel(context: context)
        postModel.id = model.id
        postModel.views = Int16(model.views)
        postModel.likes = Int16(model.likes)
        postModel.customDescription = model.description
        postModel.image = model.image
        postModel.author = model.author
        
        coreDataService.saveContext()
    }
    
    func deletePost(id: String) {
        let request = PostModel.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            guard let postModel = try coreDataService.context.fetch(request).first else { return }
            coreDataService.context.delete(postModel)
            coreDataService.saveContext()
        } catch {
            print(error)
        }
    }
    
    func containsPost(id: String) -> Bool {
        let request = PostModel.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        let result = try? coreDataService.context.fetch(request).first
        return result != nil
    }
}

