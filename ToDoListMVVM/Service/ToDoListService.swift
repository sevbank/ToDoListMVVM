//
//  ToDoListService.swift
//  ToDoListMVVM
//
//  Created by Sevban Kocabas on 29.02.2020.
//  Copyright © 2020 Sevban Kocabas. All rights reserved.
//

import Foundation

protocol ToDoListServiceProtocol {
    
}

final class ToDoListService: ToDoListServiceProtocol {
    static func fetchToDoList(completion: @escaping (Result<[ToDoItemModel], Error>) -> ()) {
        completion(.success([]))
    }
}
