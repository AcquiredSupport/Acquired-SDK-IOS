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
            if mi.children.count == 0 {continue}
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
        var url = hppSetting.is_debug ? "https://qahpp2.acquired.com" : "https://hpp.acquired.com"
        if(!query.isEmpty) {
            let index = query.index(query.endIndex, offsetBy: -1)
            query = String(query[..<index])
            url = "\(url)/?\(query)"
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
//extension String {
//    var string2SHA256: String! {
//        let str = self.cString(using: NSUTF8StringEncoding)
//        let strLen = CC_LONG(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
//        let digestLen = Int(CC_SHA256_DIGEST_LENGTH)
//        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
//        CC_SHA256(str!, strLen, result)
//        return stringFromBytes(result, length: digestLen)
//    }
//}
