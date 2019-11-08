//
//  YJHttp.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/5/28.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

import UIKit

/// URLEncode编码
public func YJURLEncode(_ str: String) -> String {
    let characters = CharacterSet(charactersIn: ":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`").inverted
    return str.addingPercentEncoding(withAllowedCharacters: characters) ?? ""
}

/// URLEncode解码
public func YJURLDecode(_ str: String?) -> String {
    return str?.removingPercentEncoding ?? ""
}

/// http 参数解析与组装
@objcMembers
public class YJURL: NSObject {
    
    /**
     * http组装
     * - Parameter url: 链接
     * - Parameter params: 参数
     * - Parameter encode: 是否 encode 编码参数
     */
    public static func assemblyParams(_ url: String?, params: Dictionary<String, Any>, encode: Bool) -> String {
        var result = ""
        for (key, var value) in params {
            if value is String {
                if encode {
                    value = YJURLEncode(value as! String)
                }
            }
            result += "&\(key)=\(value)"
        }
        if result.count != 0 {
            result = result[1..<result.count]
        }
        if url != nil {
            if result.count == 0 {
                result = url!
            } else {
                let component = url!.contains("?") ? "&": "?"
                result = url! + component + result
            }
        }
        return result
    }
    
    /**
     * http参数解析
     * - Parameter url: 链接
     * - Parameter params: 参数
     * - Parameter encode: 是否 encode 编码参数
     */
    public static func analysisParams(_ url: String, decode: Bool) -> Dictionary<String, Any> {
        var params: String = url.components(separatedBy: "?").last!
        params = params.components(separatedBy: "#")[0]
        var result = Dictionary<String, Any>()
        for item in params.components(separatedBy: "&") {
            let keyValue = item.components(separatedBy: "=")
            let key = keyValue[0]
            let value = keyValue.count == 2 ? keyValue[1] : ""
            result[key] = decode ? YJURLDecode(value) : ""
        }
        return result
    }
    
}
