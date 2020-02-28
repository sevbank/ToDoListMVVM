//
//  AppContainer.swift
//  ToDoListMVVM
//
//  Created by Sevban Kocabas on 28.02.2020.
//  Copyright © 2020 Sevban Kocabas. All rights reserved.
//

import Foundation

let app = AppContainer()

final class AppContainer {
    
    let router = AppRouter()
    let service = ToDoListService()
}
