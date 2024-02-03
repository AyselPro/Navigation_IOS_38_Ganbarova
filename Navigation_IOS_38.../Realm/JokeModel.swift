//
//  JokeModel.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 26.12.2023.
//

import Foundation
import RealmSwift

final class JokeModel: Object {
    @Persisted var value: String
    @Persisted var createdAt: Date
    @Persisted var categories: List<String>
    @Persisted(primaryKey: true) var id: String
}
