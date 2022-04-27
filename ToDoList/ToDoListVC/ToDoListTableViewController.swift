//
//  ToDoListTableViewController.swift
//  ToDoList
//
//  Created by Daria Salamakha on 20.04.2022.
//

import UIKit
// MARK: - ToDoListTableViewController
class ToDoListTableViewController: UITableViewController,
                                   ToDoCellDelegate {
    
    // MARK: - Properties
    var todos = [ToDo]()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todos = ToDo.loadTodos() ?? ToDo.sampletodos()
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCellIndetefier", for: indexPath) as! ToDoCel
        
        let toDo = todos[indexPath.row]
        cell.titleLabel?.text = toDo.title
        cell.isCompleteButton.isSelected = toDo.isComplete
        
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            ToDo.saveToDos(todos)
        }
    }
    
    // MARK: - Methods
    func checkmarkTapped(sender: ToDoCel) {
        if let indexPath = tableView.indexPath(for: sender) {
            var toDo = todos[indexPath.row]
            toDo.isComplete.toggle()
            todos[indexPath.row] = toDo
            tableView.reloadRows(at: [indexPath], with: .automatic)
            ToDo.saveToDos(todos)
        }
    }
    
    
    @IBSegueAction func editToDo(_ coder: NSCoder, sender: Any?) -> ToDoDetailTableViewController? {
        let detailController = ToDoDetailTableViewController(coder: coder)
        
        guard let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) else {
            // if sender is the add button, return an empty controller
            return detailController
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
        detailController?.toDo = todos[indexPath.row]
        
        return detailController
    }
    
    @IBAction func unwindToToDoList(_ unwindSegue: UIStoryboardSegue) {
        guard unwindSegue.identifier == "unwindSaveSegue" else { return }
        let sourceViewController = unwindSegue.source as!
        ToDoDetailTableViewController
        
        if let toDo = sourceViewController.toDo {
            if let indexOfExistingToDo = todos.firstIndex(of: toDo) {
                todos[indexOfExistingToDo] = toDo
                tableView.reloadRows(at: [IndexPath(row: indexOfExistingToDo, section: 0)], with: .automatic)
            } else {
                let newIndexPath = IndexPath(row: todos.count, section: 0)
                todos.append(toDo)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
        ToDo.saveToDos(todos)
    }
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
