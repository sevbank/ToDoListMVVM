//
//  ToDoItemModel.swift
//  ToDoListMVVM
//
//  Created by Sevban Kocabas on 29.02.2020.
//  Copyright © 2020 Sevban Kocabas. All rights reserved.
//

import Foundation

struct ToDoItemModel: Codable {
    let ownerId: String
    let id: String
    let title: String
    
    var dictionary: [String: Any] {
        return ["ownerId": ownerId, "id": id, "title": title]
    }
}
