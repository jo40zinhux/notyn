//
//  CopilotTest.swift
//  notyng
//
//  Created by João Pedro on 16/06/23.
//

import Foundation
import UIKit

// create a ToDoList view controller with UITableView and the protocols
class CopilotTest: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // create a ToDoList view controller with UITableView and the protocols
    var tableView = UITableView()
    
    // create an array of ToDoItem
    var items: [ToDoItem] = []
    
    // create a ToDoItem
    let item1 = ToDoItem(title: "João Pedro", subtitle: "")
    let item2 = ToDoItem(title: "João Pedro", subtitle: "")
    let item3 = ToDoItem(title: "João Pedro", subtitle: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set the delegate and datasource of the table view to self
        tableView.delegate = self
        tableView.dataSource = self
        
        // register the table view cell class to the table view
        tableView.register(ToDoCell.self, forCellReuseIdentifier: "ToDoCell")
        
        // add the table view to the view controller
        view.addSubview(tableView)
        
        // set the table view constraints
        setTableViewConstraints()
        
        // create an array of ToDoItem
        items = [item1, item2, item3]
    }
    
    // set the table view constraints
    func setTableViewConstraints() {
        // set the table view constraints
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    }
    
    // set the number of rows in the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    // set the content of the cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell from the prototype cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! ToDoCell
        
        // set the text from the data model
        cell.titleLabel.text = items[indexPath.row].title
        cell.subtitleLabel.text = items[indexPath.row].subtitle
        
        // return cell
        return cell
    }
    
    // set the height of the cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

}

// create a ToDoItem class
class ToDoItem {
    
    // create the properties for the title and subtitle
    var title: String
    var subtitle: String
    
    // create the initializer
    init(title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
    }
}

// create a ToDoCell class
class ToDoCell: UITableViewCell {
    
    // create the properties for the title and subtitle labels
    var titleLabel = UILabel()
    var subtitleLabel = UILabel()
    
    // create the initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // add the title label to the cell
        addSubview(titleLabel)
        
        // set the title label constraints
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        
        // add the subtitle label to the cell
        addSubview(subtitleLabel)
        
        // set the subtitle label constraints
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    }
    
    // create the required initializer
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
