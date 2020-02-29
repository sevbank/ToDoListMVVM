//
//  BaseViewController.swift
//  ToDoListMVVM
//
//  Created by Sevban Kocabas on 29.02.2020.
//  Copyright © 2020 Sevban Kocabas. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    let indicator = UIActivityIndicatorView(style: .whiteLarge)

    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.backgroundColor = UIColor.init(white: 0.3, alpha: 0.3)
    }
    
    func handleIndicator(in view: UIView, loading: Bool) {
        view.addSubview(indicator)
        indicator.withSize(.init(width: 100, height: 100))
        indicator.centerInSuperview()
        if loading {
            indicator.startAnimating()
        }else {
            indicator.stopAnimating()
        }
    }
    
    

}
