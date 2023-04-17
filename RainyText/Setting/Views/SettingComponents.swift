//
//  SettingComponents.swift
//  RainyText
//
//  Created by Shayan on 1/11/1402 AP.
//

import SwiftUI
import RainyTextView

struct CharacterSelection: View {
    @Binding var selectedLetters: Set<RainyTextView.Letters>
    var body: some View {
        ForEach(RainyTextView.Letters.allCases, id: \.rawValue) { letter in
            HStack {
                Image(systemName: selectedLetters.contains(letter) ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(.accentColor)
                Text(nameOf(letters: letter))
                
            }.onTapGesture {
                if selectedLetters.contains(letter) && selectedLetters.count > 1  {
                    selectedLetters.remove(letter)
                } else {
                    selectedLetters.insert(letter)
                }
            }
        }
    }
    
    private func nameOf(letters: RainyTextView.Letters) -> String {
        switch letters {
        case .english: return "English"
        case .arabic: return "Arabic"
        case .chinese: return "Chinese"
        case .numbers: return "Numbers"
        case .symbols: return "Symbols"
            
        }
    }
}

struct GradientColorPicker: View {
    
    var colorItems: [IdentifiableColor]
    @State private var isRemoving = false
    @State private var isAdding = false
    var onAdd: (() -> Void)?
    var onEdit: ((IdentifiableColor) -> Void)?
    var onRemove: ((IdentifiableColor) -> Void)?
    
    var body: some View {
        colorsRow
        buttons
    }
    
    var buttons: some View {
        Group {
            if isRemoving {
                 Button("Done") {
                     isRemoving = false
                }
                
            } else {
                Button("Add color") {
                    onAdd?()
                    
                }
                Button("Remove color") {
                    isRemoving = true
                }
            }
        }
    }
    
    var colorsRow: some View {
        ScrollView(.horizontal) {
            HStack{
                ForEach(colorItems) { item in
                    ZStack {
                        ColorUnit(color: item.color)
                        if isRemoving {
                            Image(systemName: "xmark")
                                .resizable()
                                .foregroundColor(.white)
                                .frame(width: 20, height: 20)
                        }
                    }
                    .onTapGesture {
                        if isRemoving {
                            onRemove?(item)
                        } else {
                            onEdit?(item)
                        }
                    }
                }
            }
        }
        
    }
}



struct BackgroundColorPicker: View {
    var color: IdentifiableColor
    var onEdit: ((IdentifiableColor) -> Void)?
    
    var body: some View {
        ColorUnit(color: color.color)
            .onTapGesture {
                onEdit?(color)
            }
    }
}


struct ColorUnit: View {
    let color: Color
    var body: some View {
        RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
            .foregroundColor(color)
            .frame(width: 55, height: 40)
    }
}