//
//  ToDoModel.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 26.12.2023.
//

import Foundation
import RealmSwift

final class ToDoModel: Object {
    @Persisted var quote: String
    @Persisted var dateCreated: Date = Date()
    
    @Persisted var items: List<Item>
}

final class Item: Object {
    @Persisted var quote: String
    @Persisted var dateCreated: Date = Date()
}
