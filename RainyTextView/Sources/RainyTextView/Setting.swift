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
        @Published public private(set) var alwaysOnScreen = false
        
        public init(rainColors: [Color], letters: Set<Letters>, backgroundColor: Color) {
            self.rainColors = rainColors
            self.letters = letters
            self.backgroundColor = backgroundColor
        }
        
        static let preview = Setting(rainColors: [.black, .green], letters: [.english, .chinese], backgroundColor: .black)
        
        public func applyChnages(rainColors: [Color]? = nil, backgroundColor: Color? = nil, letters: Set<Letters>? = nil) {
            if let rainColors { self.rainColors = rainColors }
            if let backgroundColor { self.backgroundColor = backgroundColor }
            if let letters { self.letters = letters }
        }
        
        
    }
}

