//
//  Demo1VC.swift
//  Example
//
//  Created by ganzhen on 2020/3/2.
//  Copyright © 2020 ganzhen. All rights reserved.
//

import UIKit
import Tracker

class Demo1VC: BaseViewController {

    @IBAction func clickPushBtn(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(identifier: "demo1vc") {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func clickBackToRootBtn(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func config(event: TrackerEvent) {
        event.page = "Demo1"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tracker(.loginPageShow)
    }
    
}
