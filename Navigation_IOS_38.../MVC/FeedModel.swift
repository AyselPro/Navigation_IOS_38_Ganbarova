//
//  FeedModel.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 04.12.2023.
//

import Foundation

//модель
final class FeedModel {
    static let key: NSNotification.Name = .init(rawValue: "FeedModelKeyObserver")
    private let secretWord: String = "Conditional password"
    
    func check(word: String) {
        let result = word == secretWord
        NotificationCenter.default.post(name: FeedModel.key, object: result)
    }
}
