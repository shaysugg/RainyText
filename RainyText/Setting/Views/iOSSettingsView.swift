//
//  SettingsView.swift
//  RainyText
//
//  Created by Shayan on 12/27/1401 AP.
//

import SwiftUI
import RainyTextView

#if os(iOS)
struct iOSSettingView: View {
    @Binding var isPresented: Bool
    @State private var selectedLetters: Set<RainyTextView.Letters>
    @State private var backgroundColor: IdentifiableColor
    @State private var colorItems: [IdentifiableColor]
    @State private var editingColor: IdentifiableColor?
    @State private(set) var hideStatusBar: Bool
    @State private(set) var rainHeight: Double
    
    private let rainSetting: RainyTextView.Setting
    private let appSetting: AppSetting
    
    init(rainSetting: RainyTextView.Setting, appSetting: AppSetting , isPresented: Binding<Bool>) {
        self.rainSetting = rainSetting
        self.appSetting = appSetting
        self._selectedLetters = State(initialValue: rainSetting.letters)
        self._backgroundColor = State(initialValue: IdentifiableColor(rainSetting.backgroundColor))
        self._colorItems = State(initialValue: rainSetting.rainColors.map { IdentifiableColor($0) })
        self._isPresented = isPresented
        self._hideStatusBar = State(initialValue: appSetting.hideStatusBar)
        self._rainHeight = State(initialValue: rainSetting.rainHeight)
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
                Section {
                    HeightPicker(height: $rainHeight)
                } header: {
                    Text("Rain Height")
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
                    rainSetting.applyChnages(
                        rainColors: colorItems.map(\.color),
                        backgroundColor: backgroundColor.color,
                        letters: selectedLetters,
                    rainHeight: rainHeight)
                    rainSetting.save()
                    appSetting.applyChanges(hideStatusBar: hideStatusBar)
                    appSetting.save()
                    isPresented = false
                }
            }
        }
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            iOSSettingView(rainSetting: RainyTextView.Setting.preview, appSetting: AppSetting.preview, isPresented: .constant(true))
        }
    }
}
#endif


