//
//  MainViewController.swift
//  ToDoList
//
//  Created by Nguyễn Văn Hiếu on 14/10/24.
//

import UIKit

class MainViewController: UIViewController {
    //MARK: - Properties
    private let tableView: UITableView = {
        let _tableView = UITableView()
        _tableView.showsVerticalScrollIndicator = false
        return _tableView
    }()
    
    var todoItems: [TodoItem] = []
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "To Do List"
        view.backgroundColor = .lightGray
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Đăng ký cell
        let cell = UINib(nibName: "MainTableViewCell", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: "MainTableViewCell")
        
        // Thêm bar button navigation
        let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTodo))
        navigationItem.rightBarButtonItem = addBarButtonItem
        
        setupViews()
        setupLayout()
    }
    
    //MARK: - Navigation Main -> Create
    @objc private func addTodo() {
        let createVC = CreateViewController()
        
        createVC.onCreate = { [weak self] data in
            guard let `self` = self else { return }
            
            self.todoItems.append(data)
            self.tableView.reloadData()
            
        }
        navigationController?.pushViewController(createVC, animated: true)
    }
    
    //MARK: - Setup Method
    private func setupViews() {
        view.addSubview(tableView)
    }

    private func setupLayout() {
        //Cho phép auto layout với các item
        [tableView].forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

//MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
        cell.titleLabel.text = todoItems[indexPath.row].title
        cell.descLabel.text = todoItems[indexPath.row].description
        cell.durationLabel.text = todoItems[indexPath.row].duration?.description
        cell.previewImageView.image = todoItems[indexPath.row].image
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            todoItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
}

//MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Row: \(indexPath.row)")
    }

}
