//
//  HPPManager.swfit
//  Acquired_SDK_IOS
//
//  Created by Xiaoping Li on 2018/9/4.
//  Copyright © 2018 Acquired. All rights reserved.
//

import Foundation
import WebKit

public class HppManager {
    public init(){}
    public func loadHppView(viewController:UIViewController,hppSetting:HppSetting){
        let hpp = HppViewController()
        hpp.hppUrl = generateHppUrl(hppSetting:hppSetting)
        viewController.navigationController?.pushViewController(hpp, animated: true)
    }
    
    private func generateHppUrl(hppSetting:HppSetting) ->String{
        var data = Dictionary<String, Any>()
        let mirror:Mirror = Mirror(reflecting: hppSetting)
        
        for case let (label?, value) in mirror.children {
            let mi = Mirror(reflecting: value)
            if mi.displayStyle == Mirror.DisplayStyle.optional && mi.children.count == 0 {continue}
            data[label] = unwrap(any: value)
        }
        let sortedByKeyDictionary = data.sorted { firstDictionary, secondDictionary in
            return firstDictionary.0 < secondDictionary.0
        }
        var query = String()
        var sha256_plain = String()
        for (key, value) in sortedByKeyDictionary{
            if(key == "is_debug" || key == "mid_hash" || key == "company_hash"){ continue }
            if key == "template_id", let template_id = value as? Int, template_id < 0 { continue }
            query = "\(query)\(key)=\(value)&"
            sha256_plain = "\(sha256_plain)\(value)"
        }
        var url = hppSetting.is_debug ? "https://qahpp.acquired.com" : "https://hpp.acquired.com"
        if(!query.isEmpty) {
            let index = query.index(query.endIndex, offsetBy: -1)
            query = String(query[..<index])
            url = "\(url)/?\(query)"
        }
        if(!sha256_plain.isEmpty) {
            let hash = "\(sha256_plain.sha256())\(hppSetting.mid_hash)".sha256()
            url = "\(url)&hash=\(hash)"
        }
        return url
    }
    
    func unwrap(any:Any) -> Any {
        let mi = Mirror(reflecting: any)
        if mi.displayStyle != Mirror.DisplayStyle.optional { return any }
        
        if mi.children.count == 0 { return any }
        let (_, some) = mi.children.first!
        return some
    }
}
extension String {
    
    func sha256() -> String{
        if let stringData = self.data(using: String.Encoding.utf8) {
            return hexStringFromData(input: digest(input: stringData as NSData))
        }
        return ""
    }
    
    private func digest(input : NSData) -> NSData {
        let digestLength = Int(CC_SHA256_DIGEST_LENGTH)
        var hash = [UInt8](repeating: 0, count: digestLength)
        CC_SHA256(input.bytes, UInt32(input.length), &hash)
        return NSData(bytes: hash, length: digestLength)
    }
    
    private  func hexStringFromData(input: NSData) -> String {
        var bytes = [UInt8](repeating: 0, count: input.length)
        input.getBytes(&bytes, length: input.length)
        
        var hexString = ""
        for byte in bytes {
            hexString += String(format:"%02x", UInt8(byte))
        }
        
        return hexString
    }
    
}
