//
//  Demo2VC.swift
//  Example
//
//  Created by ganzhen on 2020/3/2.
//  Copyright © 2020 ganzhen. All rights reserved.
//

import UIKit
import Tracker

class Demo2VC: BaseViewController {
    
    @IBAction func clickPresentBtn(_ sender: UIButton) {
        present(UINavigationController(rootViewController: Demo3VC()), animated: true, completion: nil)
    }
    
    func config(event: TrackerEvent) {
        event.page = "Demo2"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tracker(.homePageShow(iconOperationId: 1, isLogin: 1))
    }
}
