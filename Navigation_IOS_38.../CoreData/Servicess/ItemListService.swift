//
//  ItemListService.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 03.01.2024.
//

import CoreData

protocol IItemListService {
    var items: [ItemList] { get }
    func addItem(title: String)
    func deleteItem(at index: Int)
}

final class ItemListService: IItemListService {
    
    private(set) var items = [ItemList]()
    private let postDataService: IPostDataService = PostDataService.shared
    
    private let toDoModell: ToDoList
    
    init(toDoModell: ToDoList) {
        self.toDoModell = toDoModell
     //   fetchItems()
    }
    
  //  private func fetchItems() {
       // guard let items = toDoModell.items?.sortedArray(using: [NSSortDescriptor(key: "dateItem", ascending: false)]) as? [ItemList] else {
       //     self.items = []
        //    return
       // }
      //  self.items = items
  //  }
    
    func addItem(title: String) {
        guard let context = toDoModell.managedObjectContext else { return }
        let newItem = ItemList(context: context)
        newItem.toDoModell = toDoModell
        //toDoModell.addToItems(newItem)
        newItem.title = title
        newItem.dateItem = Date()
        postDataService.saveContext()
       // fetchItems()
    }
    
    func deleteItem(at index: Int) {
        postDataService.context.delete(items[index])
        postDataService.saveContext()
       // fetchItems()
    }
}
