//
//  ToDoListViewController.swift
//  ToDoListMVVM
//
//  Created by Sevban Kocabas on 28.02.2020.
//  Copyright © 2020 Sevban Kocabas. All rights reserved.
//

import UIKit

final class ToDoListViewController: UIViewController {
    
    private lazy var tableView = UITableView()
    
    var viewModel: ToDoListViewModel! {
        didSet {
            viewModel.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    private func setupLayout() {
        view.backgroundColor = .yellow
        view.addSubview(tableView)
        
        
    }
    

}

extension ToDoListViewController: ToDoListViewModelDelegate {
    func handleViewModelOutput(_ output: ToDoListViewModelOutput) {
        
    }
}
