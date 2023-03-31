//
//  SettingsView.swift
//  RainyText
//
//  Created by Shayan on 12/27/1401 AP.
//

import SwiftUI
#if os(iOS)
struct SettingsView: View {
    
    @State private var selectedLetters = Set<Letters>()
    @State private var backgroundColor: IdentifiableColor!
    @State private var colorItems: [IdentifiableColor]!
    @State private var isAddingColor = false
    @State private var isEditingColor = false
    
    init(setting: Setting) {
        self.selectedLetters = setting.letters
        self.backgroundColor = IdentifiableColor(setting.backgroundColor)
        self.colorItems = setting.rainColors.map { IdentifiableColor($0) }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Text("")
                Section {
                    CharacterSelection(selectedLetters: $selectedLetters)
                } header: {
                    Text("Rain Characters")
                }
                
                Section {
                    GradientColorPicker(colorItems: colorItems)
                }header: {
                    Text("Rain Colors")
                }
                Section {
                    BackgroundColorPicker(color: backgroundColor)
                } header: {
                    Text("Background Color")
                }
                
            }
            .navigationTitle("Settings")
            .toolbar {
                Button("Done") {
                    
                }
            }
        }
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SettingsView(setting: Setting.preview)
        }
    }
}
#endif




#if os(iOS)
fileprivate struct _ColorPicker: UIViewControllerRepresentable {
    
    @Binding var identifiableColor: IdentifiableColor
    let delegate = _ColorPickerDelegateAdapter()
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = UIColorPickerViewController()
        delegate.colorSelected = { color in
            self.identifiableColor = IdentifiableColor(color)
        }
        vc.delegate = delegate
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}


fileprivate class _ColorPickerDelegateAdapter: NSObject, UIColorPickerViewControllerDelegate {
    
    var colorSelected: ((Color) -> Void)?
    
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        if !continuously {
            colorSelected?(Color(uiColor: color))
            viewController.dismiss(animated: true)
        }
    }
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        print("finished")
    }
}
#endif



