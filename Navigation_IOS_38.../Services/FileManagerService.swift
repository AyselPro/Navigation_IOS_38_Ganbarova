//
//  FileManagerService.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 21.12.2023.
//

import Foundation

final class FileManagerService: FileManagerServiceDelegate {
    
    weak var delegate: FileManagerServiceDelegate?
    
    static var shared: FileManagerService = FileManagerService()
    
    private let pathForFolder: String
    private let userDefaults: UserDefaults

    var isSortedByAlphabet: Bool {
        let value = userDefaults.value(forKey: .isSortedKey) as? Bool
        return value ?? true
    }
    
    var items: [String] {
        let items = (try? FileManager.default.contentsOfDirectory(atPath: pathForFolder)) ?? []
        return isSortedByAlphabet ? items.sorted() : items
    }
    
    var rootFolderName: String {
        guard let url = URL(string: pathForFolder) else { return "Documents" }
        return url.lastPathComponent
    }
    
    init(pathForFolder: String, userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
        self.pathForFolder = pathForFolder
    }
    
    init() {
        userDefaults = UserDefaults.standard
        pathForFolder = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    }
    
    // метод добавления файла (картинки) createFile
    func createFile(name: String, content: Data) {
        let path = URL(filePath: pathForFolder + "/" + name)
        do {
            try content.write(to: path)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    //метод добавления директории createDirectory
    func addDirectory(name: String) {
        try? FileManager.default.createDirectory(atPath:  pathForFolder + "/" + name, withIntermediateDirectories: true)
    }
    
    //метод удаления контента removeContent
    func removeContent(name: String) {
        try? FileManager.default.removeItem(atPath: pathForFolder + "/" + name)
    }
    
    func getPath(at index: Int) -> String {
        pathForFolder + "/" + items[index]
    }
    
    //Проверка существования директории
    func isDirectoryAtIndex(_ index: Int) -> Bool {
        let item = items[index]
        let path = pathForFolder + "/" + item
        
        var objcBool: ObjCBool = false
        
        FileManager.default.fileExists(atPath: path, isDirectory: &objcBool)
        
        return objcBool.boolValue
    }
    
    func deleteItem(at index: Int) {
        let path = pathForFolder + "/" + items[index]
        try? FileManager.default.removeItem(atPath: path)
    }
}

















