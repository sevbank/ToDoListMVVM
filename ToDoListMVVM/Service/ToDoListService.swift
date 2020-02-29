//
//  ToDoListService.swift
//  ToDoListMVVM
//
//  Created by Sevban Kocabas on 29.02.2020.
//  Copyright © 2020 Sevban Kocabas. All rights reserved.
//

import Firebase

protocol ToDoListServiceProtocol {
    func fetchToDoList(userId: String, completion: @escaping (Result<[ToDoItemModel], Error>) -> ())
    func addNewItem(item: ToDoItemModel, completion: @escaping (Error?)->())
    func deleteItem(item: ToDoItemModel, completion: @escaping (Error?)->())
}

final class ToDoListService: ToDoListServiceProtocol {
    
    func fetchToDoList(userId: String, completion: @escaping (Result<[ToDoItemModel], Error>) -> ()) {
        
        var itemList = [ToDoItemModel]()
        Firestore.firestore().collection("users").document(userId).collection("items").getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            snapshot?.documents.forEach({ (doc) in
                let data = doc.data()
                let model = ToDoItemModel(dictionary: data)
                itemList.append(model)
            })
            DispatchQueue.main.async {
                completion(.success(itemList))
                return
            }
        }
    }
    
    func addNewItem(item: ToDoItemModel, completion: @escaping (Error?)->()) {
        let ownerId = item.ownerId
        let itemId = item.id
        let dictionary = item.dictionary
        Firestore.firestore().collection("users").document(ownerId).collection("items").document(itemId).setData(dictionary, completion: completion)
    }
    
    func deleteItem(item: ToDoItemModel, completion: @escaping (Error?) -> ()) {
        let ownerId = item.ownerId
        let itemId = item.id
        Firestore.firestore().collection("users").document(ownerId).collection("items").document(itemId).delete(completion: completion)
    }
}
