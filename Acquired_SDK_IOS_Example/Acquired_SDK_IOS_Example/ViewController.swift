//
//  ViewController.swift
//  Acquired_SDK_IOS_Example
//
//  Created by Xiaoping Li on 2018/9/4.
//  Copyright © 2018 Xiaoping Li. All rights reserved.
//

import UIKit
import Acquired_SDK_IOS
class ViewController: UIViewController {
    @IBOutlet weak var btnPayNow: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnPayNow.backgroundColor = UIColor.blue
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnPayNowClicked(_ sender: Any) {
        let hppManager = HppManager()
        let hppSetting = HppSetting(companyId:211,  companyMidId:1229,  companyHash:"hashcode")
        hppSetting.is_debug = true
        hppSetting.transaction_type = "AUTH_ONLY"
        hppSetting.currency_code_iso3 = "GBP"
        hppSetting.amount = 100.1
        hppSetting.error_url = "https://docs.acquired.com/error"
        hppSetting.return_url = "https://docs.acquired.com/return"
        hppSetting.callback_url = "https://docs.acquired.com/callback"
        hppManager.loadHppView(viewController: self, hppSetting: hppSetting)
    }
}

