//
//  IdentifiableColor.swift
//  RainyText
//
//  Created by Shayan on 1/11/1402 AP.
//

import SwiftUI

struct IdentifiableColor: Identifiable, Equatable {
    let id = UUID()
    let color: Color
    
    init(_ color: Color) {
        self.color = color
    }
    
    static func == (lhs: IdentifiableColor, rhs: IdentifiableColor) -> Bool {
        lhs.id == rhs.id
    }
}
