//
//  ToDoListViewController.swift
//  ToDoListMVVM
//
//  Created by Sevban Kocabas on 28.02.2020.
//  Copyright © 2020 Sevban Kocabas. All rights reserved.
//

import UIKit
import LBTATools
import SVProgressHUD

final class ToDoListViewController: UIViewController {
    
    private lazy var tableView = UITableView()
    
    var viewModel: ToDoListViewModel! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    private let cellId = "ToDoItemTableViewCell"
    var toDoList: [String] = []
    
    let uid = UUID().uuidString

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
    
    @objc private func addNewItem() {
        let itemId = UUID().uuidString
        let item = ToDoItemModel(ownerId: uid, id: itemId, title: "test item")
        viewModel.addNewItem(item: item)
        
    }
    

}

extension ToDoListViewController: ToDoListViewModelDelegate {
    func handleViewModelOutput(_ output: ToDoListViewModelOutput) {
        switch output {
        case .setLoading(let loading):break
//            if loading {
//                SVProgressHUD.show()
//            }else {
//                SVProgressHUD.dismiss()
//            }
        case .updateTitle(let title):
            navigationItem.title = title
        case .showToDoList(let itemList):
            toDoList = itemList
            tableView.reloadData()
        }
    }
}

extension ToDoListViewController: UITableViewDelegate {
    
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
