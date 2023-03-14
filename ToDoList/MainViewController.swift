//
//  MainViewController.swift
//  ToDoList
//
//  Created by Admin on 13.03.2023.
//

import UIKit

class MainViewController: UIViewController {

    var tasks: [TaskModel] = [] //[TaskModel(name: "Wash plates", isDone: false), TaskModel(name: "Buy products", isDone: true)]
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "CurrentTaskTableViewCell", bundle: nil), forCellReuseIdentifier: "currentTask")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    func saveData(){
        let namesTasks = tasks.map{$0.name}
        let checksTasks = tasks.map{$0.isDone}
        
        UserDefaults.standard.set(namesTasks, forKey: "namesTasks")
        UserDefaults.standard.set(checksTasks, forKey: "checksTasks")
    }
    func loadData(){
        if let namesTasks = UserDefaults.standard.value(forKey: "namesTasks") as? [String],
           let checksTasks = UserDefaults.standard.value(forKey: "checksTasks") as? [Bool]{
            let tasks = namesTasks.enumerated().map{TaskModel(name: $0.element, isDone: checksTasks[$0.offset])}
            self.tasks = tasks
            tableView.reloadData()
        }
    }
    @IBAction func pressAddTaskButton(_ sender: Any) {
        let addTaskViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddTaskViewController")
        navigationController?.pushViewController(addTaskViewController, animated: true)
    }
    
}

extension MainViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "currentTask", for: indexPath) as? CurrentTaskTableViewCell else{
            return UITableViewCell()
        }
        cell.configure(task: tasks[indexPath.row])
        return cell
    }
}
extension MainViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        var selectedTask = tasks[indexPath.row]
        selectedTask.isDone = !selectedTask.isDone
        
        tasks[indexPath.row] = selectedTask
        saveData()
        
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        tasks.remove(at: indexPath.row)
        saveData()
        
        tableView.deleteRows(at: [indexPath], with: .left)
    }
}
