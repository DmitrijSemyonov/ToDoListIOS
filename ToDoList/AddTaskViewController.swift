//
//  AddTaskViewController.swift
//  ToDoList
//
//  Created by Admin on 13.03.2023.
//

import UIKit

class AddTaskViewController: UIViewController {

    @IBOutlet weak var titleTaskTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    @IBAction func pressAddTaskButton(_ sender: Any) {
        let newTask = TaskModel(name: titleTaskTextField.text ?? "", isDone: false)
        var tasks: [TaskModel] = []
        if let namesTasks = UserDefaults.standard.value(forKey: "namesTasks") as? [String],
           let checksTasks = UserDefaults.standard.value(forKey: "checksTasks") as? [Bool]{
            tasks = namesTasks.enumerated().map{TaskModel(name: $0.element, isDone: checksTasks[$0.offset])}
            
        }
        tasks.append(newTask)
        
        let namesTasks = tasks.map{$0.name}
        let checksTasks = tasks.map{$0.isDone}
        
        UserDefaults.standard.set(namesTasks, forKey: "namesTasks")
        UserDefaults.standard.set(checksTasks, forKey: "checksTasks")
        
        navigationController?.popViewController(animated: true)
    }
}
