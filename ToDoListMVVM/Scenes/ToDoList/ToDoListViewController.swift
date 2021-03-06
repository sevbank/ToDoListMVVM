//
//  ToDoListViewController.swift
//  ToDoListMVVM
//
//  Created by Sevban Kocabas on 28.02.2020.
//  Copyright © 2020 Sevban Kocabas. All rights reserved.
//

import UIKit
import LBTATools
import Firebase

final class ToDoListViewController: BaseViewController {
    
    private lazy var tableView = UITableView()
    var viewModel: ToDoListViewModel! {
        didSet {
            viewModel.delegate = self
        }
    }
    private let cellId = "ToDoItemTableViewCell"
    var toDoList: [String] = []
    let uid: String = {
        if let uid = UserDefaults.standard.object(forKey: "uid") as? String {
            return uid
        } else {
            let uid = UUID().uuidString
            UserDefaults.standard.set(uid, forKey: "uid")
            return uid
        }
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        viewModel.load(userId: uid)
    }
    
    private func setupLayout() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ToDoItemTableViewCell.self, forCellReuseIdentifier: cellId)
        view.addSubview(tableView)
        tableView.fillSuperview()
        navigationItem.setRightBarButton(UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(addNewItem)), animated: true)
    }
    
    @objc private func deleteItem(index: Int) {
        viewModel.deleteItem(index: index)
    }
    
    @objc private func addNewItem() {
        let alertController = UIAlertController(title: "Add New Task", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Eg: Buy eggs"
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let action = UIAlertAction(title: "Add", style: .default) { (_) in
            let itemId = UUID().uuidString
            let task = alertController.textFields?.first?.text
            let item = ToDoItemModel(ownerId: self.uid, id: itemId, title: task!, timestamp: Timestamp())
            self.viewModel.addNewItem(item: item)
        }
        alertController.addAction(action)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    

}

extension ToDoListViewController: ToDoListViewModelDelegate {
    func handleViewModelOutput(_ output: ToDoListViewModelOutput) {
        switch output {
        case .setLoading(let loading):
            handleIndicator(in: self.view, loading: loading)
        case .updateTitle(let title):
            navigationItem.title = title
        case .showToDoList(let itemList):
            toDoList = itemList
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension ToDoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteItem(index: indexPath.item)
        }
    }
}

extension ToDoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ToDoItemTableViewCell
        cell.textLabel?.text = toDoList[indexPath.item]
        return cell
    }
}
