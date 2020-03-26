//
//  ViewController.swift
//  Example
//
//  Created by ganzhen on 2020/3/2.
//  Copyright © 2020 ganzhen. All rights reserved.
//

import UIKit
import Tracker

class BaseViewController: UIViewController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .random
    }
}

extension UIColor {
    static var random: UIColor {
        let red = CGFloat.random(in: 0...255) / 255.0
        let green = CGFloat.random(in: 0...255) / 255.0
        let blue = CGFloat.random(in: 0...255) / 255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
