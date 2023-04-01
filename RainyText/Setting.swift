//
//  Setting.swift
//  RainyText
//
//  Created by Shayan on 12/27/1401 AP.
//

import Foundation
import SwiftUI

class Setting: ObservableObject {
    
    @Published private(set) var rainColors: [Color]
    @Published private(set) var backgroundColor: Color
    @Published private(set) var letters: Set<Letters>
    @Published private(set) var alwaysOnScreen = false
    
    init(rainColors: [Color], letters: Set<Letters>, backgroundColor: Color) {
        self.rainColors = rainColors
        self.letters = letters
        self.backgroundColor = backgroundColor
    }
    
    static let preview = Setting(rainColors: [.black, .green], letters: [.english, .chinese], backgroundColor: .black)
    
    func applyChnages(rainColors: [Color]? = nil, backgroundColor: Color? = nil, letters: Set<Letters>? = nil) {
        if let rainColors { self.rainColors = rainColors }
        if let backgroundColor { self.backgroundColor = backgroundColor }
        if let letters { self.letters = letters }
    }
    
    
}

extension Setting {
    private enum SaveKeys {
        case rainColors
        case backgroundColor
        case letters
        
        var value: String {
            switch self {
            case .letters: return "letters"
            case .backgroundColor: return "backgroundColor"
            case .rainColors: return "rainColors"
            }
        }
    }
    
    func save() {
        let backgroundColorComponents = backgroundColor.cgColor?.components
        UserDefaults.standard.set(backgroundColorComponents, forKey: SaveKeys.backgroundColor.value)
        
        let lettersRawValue = letters.map(\.rawValue)
        UserDefaults.standard.set(lettersRawValue, forKey: SaveKeys.letters.value)
        
        let rainColorsComponents = rainColors.map { $0.cgColor?.components }
        UserDefaults.standard.set(rainColorsComponents, forKey: SaveKeys.rainColors.value)
    }
    
    static func load() -> Setting {
        var backgroundColor = Color.black
        var rainColors: [Color] = [.black, .green]
        var letters: Set<Letters> = [.english, .chinese]
        
        func color(from cgComponents: [CGFloat]) -> Color? {
            if let cgColor = CGColor(colorSpace: CGColorSpace(name: CGColorSpace.sRGB)!, components: cgComponents) {
                return Color(cgColor: cgColor)
            } else {
                return nil
            }
        }
        
        if let loadedLettersValues = UserDefaults.standard.object(forKey: SaveKeys.letters.value) as? [String] {
            let loadedLetters = loadedLettersValues.compactMap { Letters(rawValue: $0)}
            letters = Set(loadedLetters)
        }
        
        if let loadedBackgroundColorComponents = UserDefaults.standard.object(forKey: SaveKeys.backgroundColor.value) as? [CGFloat],
           let color = color(from: loadedBackgroundColorComponents) {
            
            backgroundColor = color
        }
        
        if let loadedRainColorsComponents = UserDefaults.standard.object(forKey: SaveKeys.rainColors.value) as? [[CGFloat]] {
            rainColors = loadedRainColorsComponents.compactMap { color(from: $0) }
        }
        
        return Setting(rainColors: rainColors, letters: letters, backgroundColor: backgroundColor)
    }
    
    
}
