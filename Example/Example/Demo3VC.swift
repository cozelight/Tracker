//
//  Demo3VC.swift
//  Example
//
//  Created by ganzhen on 2020/3/2.
//  Copyright © 2020 ganzhen. All rights reserved.
//

import UIKit
import Tracker

class Demo3VC: BaseViewController {
    
    func config(event: TrackerEvent) {
        event.page = "Demo3"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tracker(.sendSmsError(errorCode: "10001", errorInfo: "test"))
    }
}
