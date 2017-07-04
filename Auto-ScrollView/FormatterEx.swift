//
//  FormatterEx.swift
//  Auto-ScrollView
//
//  Created by Rick on 2017/7/3.
//  Copyright © 2017年 CXZH. All rights reserved.
//

import Foundation

enum FormatterType {
    case date //"yyyy-MM-dd"
    case time //"HH:mm:ss"
    case full //"yyyy-MM-dd HH:mm:ss"
    case shortTime //"HH:mm"
}

extension Date {
    
    func TimeStempFormDateString(WithDate dateString:String, formatter:FormatterType) -> TimeInterval {
        
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = self.typeString(formatterType: formatter)
        let date = dateFormatter.date(from: dateString)
        let timeInterval = date?.timeIntervalSince1970
        return timeInterval!
    }
    
    func DateStringFormTimeStemp(timestemp:TimeInterval, formatter:FormatterType) -> String {
        
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = self.typeString(formatterType: formatter)
        let date = Date.init(timeIntervalSince1970: timestemp)
        return dateFormatter.string(from: date)
    }
    
    private func typeString(formatterType: FormatterType) -> String {
        switch formatterType {
        case .date:
            return "yyyy-MM-dd"
        case .time:
            return "HH:mm:ss"
        case .full:
            return "yyyy-MM-dd HH:mm:ss"
        case .shortTime:
            return "HH:mm"
        }
    }
}

import UIKit

extension UIColor {
    
    func colorFromHexadecimalString(hexString: String) -> UIColor {
        
        let scanner: Scanner = Scanner.init(string: hexString)
        scanner.charactersToBeSkipped = CharacterSet.alphanumerics.inverted
        
        var value = CUnsignedInt()
        scanner.scanHexInt32(&value)
        
        let r = CGFloat((value & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((value & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(value & 0x0000FF) / 255.0
        
        return UIColor.init(red: r, green: g, blue: b, alpha: 1)
    }
    
    func colorFormRGBAString(string: String) -> UIColor {
        
        let scanner: Scanner = Scanner.init(string: string)
        scanner.charactersToBeSkipped = CharacterSet.decimalDigits.inverted
        
        var r: Int = 0
        var g: Int = 0
        var b: Int = 0
        var a: Float = 1.0
        
        scanner.scanInt(&r)
        scanner.scanInt(&g)
        scanner.scanInt(&b)
        
        if scanner.scanFloat(&a) {
            return UIColor.init(red: (CGFloat(r) / 255.0), green: (CGFloat(g) / 255.0), blue: (CGFloat(b) / 255.0), alpha: CGFloat(a))
        }
        else {
            return UIColor.init(red: (CGFloat(r) / 255.0), green: (CGFloat(g) / 255.0), blue: (CGFloat(b) / 255.0), alpha: 1.0)
        }
    }
    
    func colorFromRGBString(string: String) -> UIColor {
        
        return self.colorFormRGBAString(string: string)
    }
}











