//
//  CheckPass.swift
//  Navigation_IOS_38_Ganbarova
//
//  Created by Aysel on 22.11.2023.
//

import Foundation
import CommonCrypto

extension Data{
    public func aysel30() -> String {
        return hexStringFromData(input: digest(input: self as NSData))
            }
            
            private func digest(input : NSData) -> NSData {
                let digestLength = Int(CC_SHA384_DIGEST_LENGTH)
                let hash = [UInt8](repeating: 0, count: digestLength)
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

public extension String {
    func aysel30() -> String{
        if let stringData = self.data(using: String.Encoding.utf8) {
            return stringData.aysel30()
        }
        return ""
    }
}
