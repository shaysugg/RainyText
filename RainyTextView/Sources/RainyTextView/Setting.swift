//
//  Setting.swift
//  RainyText
//
//  Created by Shayan on 12/27/1401 AP.
//

import Foundation
import SwiftUI

public extension RainyTextView {
    class Setting: ObservableObject {
        
        @Published public private(set) var rainColors: [Color]
        @Published public private(set) var backgroundColor: Color
        @Published public private(set) var letters: Set<Letters>
        @Published public private(set) var rainHeight: Double
        @Published public private(set) var lastChangeDate: Date?
        @Published public private(set) var rainSpeed: RainSpeed
        
        public init(rainColors: [Color], letters: Set<Letters>, backgroundColor: Color, rainHeight: Double, rainSpeed: RainSpeed) {
            self.rainColors = rainColors
            self.letters = letters
            self.backgroundColor = backgroundColor
            self.rainHeight = rainHeight
            self.rainSpeed = rainSpeed
        }
        
        public func applyChanges(rainColors: [Color]? = nil, backgroundColor: Color? = nil, letters: Set<Letters>? = nil, rainHeight: Double? = nil, rainSpeed: RainSpeed? = nil) {
            if let rainColors { self.rainColors = rainColors }
            if let backgroundColor { self.backgroundColor = backgroundColor }
            if let letters { self.letters = letters }
            if let rainHeight { self.rainHeight = rainHeight }
            if let rainSpeed { self.rainSpeed = rainSpeed }
            lastChangeDate = Date()
        }
        
        static let preview = Setting(rainColors: [.black, .green], letters: [.english, .chinese], backgroundColor: .black, rainHeight: 200, rainSpeed: .medium)
    }
}

public extension RainyTextView.Setting {
    enum RainSpeed: Int, CaseIterable {
        case verySlow
        case slow
        case medium
        case fast
        case veryFast
    }
}
