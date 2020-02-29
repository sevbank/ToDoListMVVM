//
//  ToDoListViewModel.swift
//  ToDoListMVVM
//
//  Created by Sevban Kocabas on 28.02.2020.
//  Copyright © 2020 Sevban Kocabas. All rights reserved.
//

import Foundation

class ToDoListViewModel: ToDoListViewModelProtocol {
    
    weak var delegate: ToDoListViewModelDelegate?
    private let service: ToDoListServiceProtocol
    private var toDoList: [ToDoItemModel] = []
    
    init(service: ToDoListServiceProtocol) {
        self.service = service
    }
    
    func load(userId: String) {
        notify(.setLoading(true))
        notify(.updateTitle("Items"))
        service.fetchToDoList(userId: userId) { (result) in
            self.notify(.setLoading(false))
            switch result {
            case .failure(let error):
                print(error)
            case .success(let items):
                self.toDoList = items
                self.notify(.showToDoList(items.map{$0.title}))
            }
        }
    }
    
    func addNewItem(item: ToDoItemModel) {
        notify(.setLoading(true))
        service.addNewItem(item: item) { (error) in
            self.notify(.setLoading(false))
            if let error = error {
                print(error)
                return
            }
            self.load(userId: item.ownerId)
        }
    }
    
    private func notify(_ output: ToDoListViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
    
}
