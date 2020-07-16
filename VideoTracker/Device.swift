//
//  Device.swift
//  SmartIntercom
//
//  Created by Андрей Лупул on 03/06/2019.
//  Copyright © 2019 MTS IoT. All rights reserved.
//

import UIKit


enum DeviceType {
    case iPhoneSE, iPhone7, iPhone8Plus, iPhoneX, iphoneXR, iPad, iPadWide, iPadHorizontal
}

// TODO: привести к одному виду, тут не учтены XR и XSMax
enum Device {
    static func type() -> DeviceType {
        if UIScreen.main.bounds.height < UIScreen.main.bounds.width {
            return .iPadHorizontal
        } else {
            switch UIScreen.main.bounds.height {
            case 0...568:
                return .iPhoneSE
            case 569...667:
                return .iPhone7
            case 668...736:
                return .iPhone8Plus
            case 737...812:
                return .iPhoneX
            case 813...1024:
                return .iPad
            case 1025...1792:
                return .iphoneXR
            default:
                return .iPadWide
            }
        }
    }
    
    static func isSmall() -> Bool {
        return UIScreen.main.bounds.height < 736
    }
}
