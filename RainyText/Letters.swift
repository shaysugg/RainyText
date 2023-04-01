//
//  Letters.swift
//  RainyText
//
//  Created by Shayan on 12/27/1401 AP.
//

import Foundation

enum Letters: String, CaseIterable {
    case english = "english"
    case arabic = "arabic"
    case chinese = "chinese"
    case numbers = "numbers"
    case symbols = "symbols"
    
    var characters: String {
        switch self {
        case .english:
            return "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        case .arabic:
            return "ابتثجحخدذرزسشصضطظعغفقكلمنهوي"
        case .chinese:
            return "我是一个语言模型很高兴为您服务中文是一门非常有趣和复杂的语言要不断的学习和练习才能掌握好希望您能够享受学习中文的过程"
        case .numbers:
            return "1234567890"
        case .symbols:
            return "!@#$%^&*()"
        }
    }
    
    static func generateRandomCharacter(from letters: Set<Letters>) -> String {
        String(letters.flatMap { $0.characters }.randomElement()!)
    }
}
