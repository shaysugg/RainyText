//
//  SettingsView.swift
//  RainyText
//
//  Created by Shayan on 12/27/1401 AP.
//

import SwiftUI
#if os(iOS)
struct iOSSettingView: View {
    @Binding var isPresented: Bool
    @State private var selectedLetters: Set<Letters>
    @State private var backgroundColor: IdentifiableColor
    @State private var colorItems: [IdentifiableColor]
    @State private var editingColor: IdentifiableColor?
    @State private(set) var hideStatusBar: Bool
    
    private let setting: Setting
    
    init(setting: Setting, isPresented: Binding<Bool>) {
        self.setting = setting
        self._selectedLetters = State(initialValue: setting.letters)
        self._backgroundColor = State(initialValue: IdentifiableColor(setting.backgroundColor))
        self._colorItems = State(initialValue: setting.rainColors.map { IdentifiableColor($0) })
        self._isPresented = isPresented
        self._hideStatusBar = State(initialValue: setting.hideStatusBar)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    CharacterSelection(selectedLetters: $selectedLetters)
                } header: {
                    Text("Rain Characters")
                }
                
                Section {
                    GradientColorPicker(colorItems: colorItems, onAdd: {
                        let newColor = IdentifiableColor(.red)
                        colorItems.append(newColor)
                        editingColor = newColor
                    }, onEdit: { color in
                        editingColor = color
                    }, onRemove: { color in
                        guard colorItems.count > 1 else { return }
                        colorItems.removeAll { $0.id == color.id }
                    })
                }header: {
                    Text("Rain Colors")
                }
                Section {
                    BackgroundColorPicker(color: backgroundColor) { color in
                        editingColor = color
                    }
                } header: {
                    Text("Background Color")
                }
                Section {
                    Toggle("Hide StatusBar", isOn: $hideStatusBar)
                }
                
                
            }
            .sheet(item: $editingColor) { editingColor in
                iOSColorPicker(color: editingColor.color) { color in
                    let pickedColor = IdentifiableColor(color)
                    if let index = colorItems.firstIndex(of: editingColor) {
                        colorItems[index] = pickedColor
                    }else if backgroundColor == editingColor {
                        backgroundColor = pickedColor
                    }
                    self.editingColor = nil
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                Button("Done") {
                    setting.applyChnages(rainColors: colorItems.map(\.color), backgroundColor: backgroundColor.color, letters: selectedLetters, hideStatusBar: hideStatusBar)
                    setting.save()
                    isPresented = false
                }
            }
        }
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            iOSSettingView(setting: Setting.preview, isPresented: .constant(true))
        }
    }
}
#endif


