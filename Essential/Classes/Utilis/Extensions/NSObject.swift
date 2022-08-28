//
//  NSObject.swift
//  Essentials
//
//  Created by Jordan Kenarov on 20.09.21.
//

import Foundation
public extension NSObject {
    func allClasses<R>(_ body: (UnsafeBufferPointer<AnyClass>) throws -> R) rethrows -> R {
        var count: UInt32 = 0
        let classListPtr = objc_copyClassList(&count)
        defer {
            free(UnsafeMutableRawPointer(classListPtr))
        }
        let classListBuffer = UnsafeBufferPointer(start: classListPtr, count: Int(count))
        return try body(classListBuffer)
    }
    
    
    func allMethods(_ anyClass: AnyClass) {
        var methodCount:UInt32 = 0
        let methodlist = class_copyMethodList(anyClass, &methodCount)
        for  i in 0..<numericCast(methodCount) {
            if let method = methodlist?[i]{
                let methodName = method_getName(method);
                dump("Method : \(String(describing: methodName))")
            }
        }
    }
    
    func allProperties(_ anyClass: AnyClass) {
        var count:UInt32 = 0
        let proList = class_copyPropertyList(anyClass, &count)
        for  i in 0..<numericCast(count) {
            if let property = proList?[i]{
                let propertyName = property_getName(property);
                dump("Property : \(String(utf8String: propertyName) ?? "")")
            }else{
            }
        }
    }
    
    func allIvars(_ anyClass: AnyClass)   {
        
        var count: UInt32 = 0
        let ivars = class_copyIvarList(anyClass, &count)
        
        for i in 0..<count {
            let name = NSString(cString: ivar_getName(ivars![Int(i)])!, encoding: String.Encoding.utf8.rawValue)
            dump("Ivar : \(name ?? ""))")
        }
    }
    
}
