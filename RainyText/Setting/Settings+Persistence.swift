//
//  Setting+Persist.swift
//  RainyText
//
//  Created by Shayan on 1/28/1402 AP.
//

import Foundation
import RainyTextView
import SwiftUI

extension AppSetting {
    private enum Keys: String {
        case hideStatusBar
        case alwaysOnScren
    }
    
    func save() {
        UserDefaults.standard.set(hideStatusBar, forKey: Keys.hideStatusBar.rawValue)
        UserDefaults.standard.set(alwaysOnScren, forKey: Keys.alwaysOnScren.rawValue)
    }
    
    static func load() -> AppSetting {
        let hideStatusBar = UserDefaults.standard.bool(forKey: Keys.hideStatusBar.rawValue)
        let alwaysOnScren = UserDefaults.standard.bool(forKey: Keys.alwaysOnScren.rawValue)
        return AppSetting(hideStatusBar: hideStatusBar, alwaysOnScren: alwaysOnScren)
    }
}




extension RainyTextView.Setting {
    private enum Keys: String {
        case rainColors
        case backgroundColor
        case letters
        case rainHeight
        case lastChangeDate
        case rainSpeed
    }
    
    func save() {
        let backgroundColorComponents = backgroundColor.cgColor?.components
        UserDefaults.standard.set(backgroundColorComponents, forKey: Keys.backgroundColor.rawValue)
        
        let lettersRawValue = letters.map(\.rawValue)
        UserDefaults.standard.set(lettersRawValue, forKey: Keys.letters.rawValue)
        
        let rainColorsComponents = rainColors.compactMap { $0.cgColor?.components }
        UserDefaults.standard.set(rainColorsComponents, forKey: Keys.rainColors.rawValue)
        
        UserDefaults.standard.set(rainHeight, forKey: Keys.rainHeight.rawValue)
        
        UserDefaults.standard.set(rainSpeed.rawValue, forKey: Keys.rainSpeed.rawValue)
    }
    
    static func load() -> RainyTextView.Setting {
        var backgroundColor = Color.black
        var rainColors: [Color] = [.black, .green]
        var letters: Set<RainyTextView.Letters> = [.english, .chinese]
        var rainHeight: Double = (RainyTextView.rainHeight.upperBound - RainyTextView.rainHeight.lowerBound) / 2
        var rainSpeed: Int = RainSpeed.medium.rawValue
        
        func color(from cgComponents: [CGFloat]) -> Color? {
            if let cgColor = CGColor(colorSpace: CGColorSpace(name: CGColorSpace.sRGB)!, components: cgComponents) {
                return Color(cgColor: cgColor)
            } else {
                return nil
            }
        }
        
        if let loadedLettersValues = UserDefaults.standard.object(forKey: Keys.letters.rawValue) as? [String] {
            let loadedLetters = loadedLettersValues.compactMap { RainyTextView.Letters(rawValue: $0)}
            letters = Set(loadedLetters)
        }
        
        if let loadedBackgroundColorComponents = UserDefaults.standard.object(forKey: Keys.backgroundColor.rawValue) as? [CGFloat],
           let color = color(from: loadedBackgroundColorComponents) {
            
            backgroundColor = color
        }
        
        if let loadedRainColorsComponents = UserDefaults.standard.object(forKey: Keys.rainColors.rawValue) as? [[CGFloat]] {
            rainColors = loadedRainColorsComponents.compactMap { color(from: $0) }
        }
        
        if let loadedRainLentgh = UserDefaults.standard.object(forKey: Keys.rainHeight.rawValue) as? Double {
            rainHeight = loadedRainLentgh
        }
        
        if let loadedRainSpeed = UserDefaults.standard.object(forKey: Keys.rainSpeed.rawValue) as? Int {
            rainSpeed = loadedRainSpeed
        }
        
        return RainyTextView.Setting(rainColors: rainColors, letters: letters, backgroundColor: backgroundColor, rainHeight: rainHeight, rainSpeed: RainSpeed(rawValue: rainSpeed)!)
    }
    
    
}
