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
        hppSetting.callback_url = "https://yoururl.com/callback"
        hppSetting.is_tds = 2
        hppSetting.tds_type = 2
        hppSetting.tds_preference = 0
        hppSetting.tds_source = 1
        
        hppSetting.customer_fname = "Joe"
        hppSetting.customer_lname = "Bloggs"
        hppSetting.customer_dob = "1990-01-01"
        hppSetting.billing_street = "152 Aldgate Drive"
        hppSetting.billing_city = "London"
        hppSetting.billing_zipcode = "E1 7RT"
        hppSetting.billing_country_code_iso2 = "GB"
        hppSetting.billing_phone_code = "44"
        hppSetting.billing_phone = "2039826580"
        hppSetting.billing_email = "support@acquired.com"
        hppSetting.merchant_contact_url = "https://acquired.com/support"
        hppManager.loadHppView(viewController: self, hppSetting: hppSetting)
    }
}

