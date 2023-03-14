//
//  CurrentTaskTableViewCell.swift
//  ToDoList
//
//  Created by Admin on 13.03.2023.
//

import UIKit

class CurrentTaskTableViewCell: UITableViewCell {

    @IBOutlet weak var checkbox: UIImageView!
    
    @IBOutlet weak var titleTask: UILabel!
    
    func configure(task: TaskModel){
        titleTask.text = task.name
        let checkName = task.isDone ? "checkmark.circle.fill" : "circle"
        checkbox.image = UIImage(systemName: checkName)
    }
}
