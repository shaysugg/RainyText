//
//  Letters.swift
//  RainyText
//
//  Created by Shayan on 12/27/1401 AP.
//

import Foundation

enum Letters: String, CaseIterable {
    case english = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    case arabic = "ابتثجحخدذرزسشصضطظعغفقكلمنهوي"
    case chinese = "我是一个语言模型很高兴为您服务中文是一门非常有趣和复杂的语言要不断的学习和练习才能掌握好希望您能够享受学习中文的过程"
    case numbers = "1234567890"
    case symbols = "!@#$%^&*()"
    
    static func generateRandomCharacter(from letters: Set<Letters>) -> String {
        String(letters.flatMap { $0.rawValue }.randomElement()!)
    }
}
