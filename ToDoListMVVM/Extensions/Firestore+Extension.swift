//
//  Firestore+Extension.swift
//  ToDoListMVVM
//
//  Created by Sevban Kocabas on 29.02.2020.
//  Copyright © 2020 Sevban Kocabas. All rights reserved.
//

import Firebase

extension DocumentSnapshot {
    
    func decode<T: Decodable>(as objectType: T.Type, includingId: Bool = true) throws  -> T {
        
        var documentJson = data()
        if includingId {
            documentJson?["id"] = documentID
        }
        
        let documentData = try JSONSerialization.data(withJSONObject: documentJson, options: [])
        let decodedObject = try JSONDecoder().decode(objectType, from: documentData)
        
        return decodedObject
    }
    
}
