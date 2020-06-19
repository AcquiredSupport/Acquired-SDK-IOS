//
//  HppSetting.swift
//  Acquired_SDK_IOS
//
//  Created by Xiaoping Li on 2018/9/6.
//  Copyright © 2018 Acquired. All rights reserved.
//

import Foundation
public class HppSetting{
    public init( companyId:Int,  companyMidId:Int,  companyHash:String){
        self.company_id = companyId
        self.company_mid_id = companyMidId
        self.mid_hash = companyHash
        self.merchant_order_id = self.generateOrderId()
        }


    public var is_debug = false

    public var company_id: Int
    public var company_mid_id: Int
    public var mid_hash: String
    public var transaction_type: String?
    public var currency_code_iso3 :String?
    public var merchant_order_id :String?
    public var template_id: Int?
    public var amount: Float?
    public var callback_url: String?
    public var return_url: String?
    public var error_url: String?

    public var merchant_customer_id: String?
    public var merchant_custom_1: String?
    public var merchant_custom_2: String?
    public var merchant_custom_3: String?
    public var merchant_contact_url: String?

    public var customer_title: String?
    public var customer_fname: String?
    public var customer_mname: String?
    public var customer_lname: String?
    public var customer_gender: String?
    public var customer_dob: String?
    public var customer_company: String?

    public var billing_street: String?
    public var billing_street2: String?
    public var billing_city: String?
    public var billing_state: String?
    public var billing_zipcode: String?
    public var billing_country_code_iso2: String?
    public var billing_email: String?
    public var billing_phone: String?
    public var billing_phone_code: String?

    public var shipping_street: String?
    public var shipping_street2: String?
    public var shipping_city: String?
    public var shipping_state: String?
    public var shipping_zipcode: String?
    public var shipping_country_code_iso2: String?
    public var shipping_email: String?
    public var shipping_phone: String?

    public var is_tds: Int?
    public var tds_source: Int?
    public var tds_type: Int?
    public var tds_preference: Int?
    public var return_method: String?


    private func generateOrderId()->String{
        let date = Date()
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "yyyyMMddHHmmss"

        return  dateFormatter.string(from: date)

    }



}
