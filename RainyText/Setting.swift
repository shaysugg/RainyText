//
//  Setting.swift
//  RainyText
//
//  Created by Shayan on 12/27/1401 AP.
//

import Foundation
import SwiftUI

class Setting: ObservableObject {
    
    @Published var rainColors: [Color]
    @Published var backgroundColor: Color
    @Published var letters: Set<Letters>
    
    init(rainColors: [Color], letters: Set<Letters>, backgroundColor: Color) {
        self.rainColors = rainColors
        self.letters = letters
        self.backgroundColor = backgroundColor
    }
    
    static let simulator = Setting(rainColors: [.black, .green], letters: [.english, .chinese], backgroundColor: .black)
}
