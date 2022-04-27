//
//  ToDo.swift
//  ToDoList
//
//  Created by Daria Salamakha on 20.04.2022.
//

import Foundation

// MARK: - ToDo
struct ToDo: Equatable, Codable {
    
    // MARK: - Properties
    let id: UUID
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?
    static var archiveURL: URL {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentDirectory.appendingPathComponent("toDos").appendingPathExtension("plist")
        return archiveURL
    }
    
    init(title: String, isComplete: Bool, dueDate: Date,
         notes: String?) {
        self.id = UUID()
        self.title = title
        self.isComplete = isComplete
        self.dueDate = dueDate
        self.notes = notes
    }
    
    // MARK: - Methods
    static func ==(lhs: ToDo, rhs: ToDo) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func loadTodos() -> [ToDo]? {
        guard let codedToDos = try? Data(contentsOf: archiveURL) else {return nil}
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<ToDo>.self,
                                               from: codedToDos)
    }
    
    static func saveToDos(_ toDos: [ToDo]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedToDos = try? propertyListEncoder.encode(toDos)
        try? codedToDos?.write(to: archiveURL, options: .noFileProtection)
    }
    
    static func sampletodos() -> [ToDo] {
        let todo1 = ToDo(title: "Todo1", isComplete: false, dueDate: Date(), notes: "Notes 1")
        let todo2 = ToDo(title: "Todo2", isComplete: false, dueDate: Date(), notes: "Notes 2")
        let todo3 = ToDo(title: "Todo3", isComplete: false, dueDate: Date(), notes: "Notes 3")
        
        return [todo1, todo2, todo3]
    }
}
