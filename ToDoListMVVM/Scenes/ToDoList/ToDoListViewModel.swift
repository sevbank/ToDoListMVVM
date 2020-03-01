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
        service.fetchToDoList(userId: userId) { [weak self] (result) in
            guard let `self` = self else {return}
            self.notify(.setLoading(false))
            switch result {
            case .failure(let error):
                print(error)
            case .success(let items):
                self.toDoList = items.sorted{$0.timestamp.dateValue() > $1.timestamp.dateValue()}
                self.notify(.showToDoList(self.toDoList.map{$0.title}))
            }
        }
    }
    
    func addNewItem(item: ToDoItemModel) {
        notify(.setLoading(true))
        service.addNewItem(item: item) { [weak self] (error) in
            guard let `self` = self else {return}
            self.notify(.setLoading(false))
            if let error = error {
                print(error)
                return
            }
            self.load(userId: item.ownerId)
        }
    }
    
    func deleteItem(index: Int) {
        let item = toDoList[index]
        notify(.setLoading(true))
        service.deleteItem(item: item) { [weak self] (error) in
            guard let `self` = self else {return}
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
