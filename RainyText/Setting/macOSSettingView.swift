//
//  macOSSettingView.swift
//  RainyText
//
//  Created by Shayan on 1/11/1402 AP.
//

import SwiftUI
#if os(macOS)
struct macOSSettingView: View {
    @ObservedObject private var setting: Setting
    @ObservedObject private var vm: macOSSettingVM
    
    init(setting: Setting) {
        self.setting = setting
        self.vm = macOSSettingVM(setting: setting)
    }
    var body: some View {
            Form {
                Section {
                    CharacterSelection(selectedLetters: $vm.selectedLetters)
                } header: {
                    Text("Rain Characters")
                }
                Divider()
                Section {
                    GradientColorPicker(colorItems: vm.colorItems, onAdd: vm.addNewColor, onEdit: vm.edit(color:), onRemove: vm.remove(color:))
                }header: {
                    Text("Rain Colors")
                }
                Divider()
                Section {
                    BackgroundColorPicker(color: vm.backgroundColor, onEdit: vm.edit(color:))
                } header: {
                    Text("Background Color")
                }
                Divider()
                Spacer()
                HStack {
                    Spacer()
                    Button("Apply") {
                        setting.applyChnages(
                            rainColors: vm.colorItems.map(\.color),
                            backgroundColor: vm.backgroundColor.color,
                            letters: vm.selectedLetters)
                    }
                    Button("Save") {
                        setting.save()
                    }
                }
            }
            .padding()
            .navigationTitle("Settings")
    }
}

struct macOSSettingView_Previews: PreviewProvider {
    static var previews: some View {
        macOSSettingView(setting: Setting.preview)
            .previewLayout(.fixed(width: 400, height: 800))
    }
}
#endif

