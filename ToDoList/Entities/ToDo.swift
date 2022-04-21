//
//  ToDo.swift
//  ToDoList
//
//  Created by Daria Salamakha on 20.04.2022.
//

import Foundation

struct ToDo: Equatable {
    
    let id = UUID()
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?
    
    static func ==(lhs: ToDo, rhs: ToDo) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func loadTodos() -> [ToDo]? {
        return nil
    }
    
    static func sampletodos() -> [ToDo] {
        let todo1 = ToDo(title: "Todo1", isComplete: false, dueDate: Date(), notes: "Notes 1")
        let todo2 = ToDo(title: "Todo2", isComplete: false, dueDate: Date(), notes: "Notes 2")
        let todo3 = ToDo(title: "Todo3", isComplete: false, dueDate: Date(), notes: "Notes 3")
        
        return [todo1, todo2, todo3]
    }
}
