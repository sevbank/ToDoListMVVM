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
    func deleteItem(index: Int)
}

enum ToDoListViewModelOutput: Equatable {
    case updateTitle(String)
    case setLoading(Bool)
    case showToDoList([String])//if more complex than string, use presentation model
}

protocol ToDoListViewModelDelegate: class {
    func handleViewModelOutput(_ output: ToDoListViewModelOutput)
}
