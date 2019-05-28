//
//  YJNSSingletonCenter.swift
//  Pods
//
//  Created by 阳君 on 2019/5/22.
//

import Foundation

/// 获取强引用单例
public func YJStrongSingleton(_ aClass: AnyClass, _ identifier: String?) -> AnyObject {
    return YJNSSingletonCenter.defaultCenter.strongSingleton(aClass: aClass, forIdentifier: identifier)
}

/// 获取弱引用单例
public func YJWeakSingleton(_ aClass: AnyClass, _ identifier: String) -> AnyObject {
    return YJNSSingletonCenter.defaultCenter.weakSingleton(aClass: aClass, forIdentifier: identifier)
}

/** 单例中心*/
open class YJNSSingletonCenter: NSObject & NSCacheDelegate {
    
    static var defaultCenter = YJNSSingletonCenter()
    
    private let mutex = YJPthreadMutex()
    private var strongDict = YJNSSafetyDictionary()
    private var weakCache = YJNSSafetyCache<NSString, YJNSSingletonModel>()
    
    public override init() {
        super.init()
        self.weakCache.delegate = self
    }
    
    /// 强引用单例，一直存在
    func strongSingleton(aClass: AnyClass, forIdentifier identifier: String?) -> AnyObject {
        let identifier = identifier ?? NSStringFromClass(aClass) as String
        let model = self.mutex.lockObj {[unowned self] () -> AnyObject in
            guard let model = self.strongDict[identifier] else {
                let model = YJNSSingletonModel()
                self.strongDict[identifier] = model
                return model
            }
            return model as AnyObject
        }
        return (model as! YJNSSingletonModel).object(aClass: aClass, forIdentifier: identifier)
    }
    
    /// 弱引用单例，自动回收
    func weakSingleton(aClass: AnyClass, forIdentifier identifier: String) -> AnyObject {
        let identifier1 = identifier as NSString
        let model = self.mutex.lockObj {[unowned self] () -> AnyObject in
            guard let model = self.weakCache.object(forKey: identifier1) else {
                let model = YJNSSingletonModel()
                self.weakCache.setObject(model, forKey: identifier1)
                return model
            }
            return model
        }
        return (model as! YJNSSingletonModel).object(aClass: aClass, forIdentifier: identifier)
    }
    
    /// 移除弱引用单例
    func removeWeakSingleton(forIdentifier identifier: String) {
        self.mutex.lock { [unowned self] in
            self.weakCache.removeObject(forKey: identifier as NSString)
        }
    }
    
    // MARK: NSCacheDelegate
    public func cache(_ cache: NSCache<AnyObject, AnyObject>, willEvictObject obj: Any) {
        print("[YJCocoa] 释放：\(obj)")
    }
    
}