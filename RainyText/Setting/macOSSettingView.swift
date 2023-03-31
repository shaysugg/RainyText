//
//  macOSSettingView.swift
//  RainyText
//
//  Created by Shayan on 1/11/1402 AP.
//

import SwiftUI
#if os(macOS)
struct macOSSettingView: View {
    
    @ObservedObject private var vm: macOSSettingVM
    private let setting: Setting
    init(setting: Setting) {
        self.setting = setting
        self.vm = macOSSettingVM(setting: setting)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    CharacterSelection(selectedLetters: $vm.selectedLetters)
                } header: {
                    Text("Rain Characters")
                }

                Section {
                    GradientColorPicker(colorItems: vm.colorItems, onAdd: vm.addNewColor, onEdit: vm.edit(color:), onRemove: vm.remove(color:))
                }header: {
                    Text("Rain Colors")
                }

                Section {
                    BackgroundColorPicker(color: vm.backgroundColor, onEdit: vm.edit(color:))
                } header: {
                    Text("Background Color")
                }

            }
            .navigationTitle("Settings")
            .toolbar {
                Button("Done") {
                    setting.backgroundColor = vm.backgroundColor.color
                    setting.rainColors = vm.colorItems.map(\.color)
                    setting.letters = vm.selectedLetters
                }
            }
        }
    }
}

struct macOSSettingView_Previews: PreviewProvider {
    static var previews: some View {
        macOSSettingView(setting: Setting.preview)
    }
}
#endif
