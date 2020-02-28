//
//  ToDoListBuilder.swift
//  ToDoListMVVM
//
//  Created by Sevban Kocabas on 28.02.2020.
//  Copyright © 2020 Sevban Kocabas. All rights reserved.
//

import Foundation

final class ToDoListBuilder {
    
    static func make() -> ToDoListViewController {
        let viewController = ToDoListViewController()
        viewController.viewModel = ToDoListViewModel(service: app.service)
        return viewController
    }
    
}
