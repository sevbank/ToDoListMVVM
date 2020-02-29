//
//  ToDoItemModel.swift
//  ToDoListMVVM
//
//  Created by Sevban Kocabas on 29.02.2020.
//  Copyright © 2020 Sevban Kocabas. All rights reserved.
//

import Firebase

class ToDoItemModel {
    var ownerId: String
    var id: String
    var title: String
    var timestamp: Timestamp
    var dictionary: [String: Any] {
        return ["ownerId": ownerId, "id": id, "title": title, "timestamp": timestamp]
    }
    
    init(ownerId: String, id: String, title: String, timestamp: Timestamp) {
        self.ownerId = ownerId
        self.id = id
        self.title = title
        self.timestamp = timestamp
    }
    
    init(dictionary: [String: Any]) {
        self.ownerId = dictionary["ownerId"] as? String ?? ""
        self.id = dictionary["id"] as? String ?? ""
        self.title = dictionary["title"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp()
    }
}
