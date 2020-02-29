//
//  ToDoListContracts.swift
//  ToDoListMVVM
//
//  Created by Sevban Kocabas on 28.02.2020.
//  Copyright © 2020 Sevban Kocabas. All rights reserved.
//

import Foundation

protocol ToDoListViewModelProtocol {
    var delegate: ToDoListViewModelDelegate? {get set}
    func load(userId: String)
    func addNewItem(item: ToDoItemModel)
}

enum ToDoListViewModelOutput: Equatable {
    case updateTitle(String)
    case setLoading(Bool)
    case showToDoList([String])
}

protocol ToDoListViewModelDelegate: class {
    func handleViewModelOutput(_ output: ToDoListViewModelOutput)
}
