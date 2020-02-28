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
    
    func load() {
        
    }
    
    private func notify(_ output: ToDoListViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
    
}
