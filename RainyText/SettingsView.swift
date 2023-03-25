//
//  SettingsView.swift
//  RainyText
//
//  Created by Shayan on 12/27/1401 AP.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var selectedLetters: Set<Letters>
    @State private var backgroundColor: Color
    @State private var colorItems: [ColorItem]
    
    init(setting: Setting) {
        self.selectedLetters = setting.letters
        self.backgroundColor = setting.backgroundColor
        self.colorItems = setting.rainColors.map { ColorItem($0) }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    ForEach(Letters.allCases, id: \.rawValue) { letter in
                        HStack {
                            Image(systemName: selectedLetters.contains(letter) ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(.accentColor)
                            Text(nameOf(letters: letter))
                            
                        }.onTapGesture {
                            if selectedLetters.contains(letter) {
                                selectedLetters.remove(letter)
                            } else {
                                selectedLetters.insert(letter)
                            }
                        }
                    }
                } header: {
                    Text("Rain Characters")
                }
                
                Section {
                    GradientColorPicker(colorItems: $colorItems)
                }header: {
                    Text("Rain Colors")
                }
                
                Section {
                    HStack {
                        Text("Background Color:")
                        Spacer()
                        ColorUnit(color: backgroundColor)
                    }
                }
                
            }
            .navigationTitle("Settings")
            .toolbar {
                Button("Done") {
                    
                }
            }
        }
    }
    
    func nameOf(letters: Letters) -> String {
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
    
    @Binding fileprivate var colorItems: [ColorItem]
    @State var isRemoving = false
    @State fileprivate var editingItem: ColorItem?
    @State var isAdding: Bool = false
    
    var body: some View {
   
        colorsRow
        buttons
        
        .sheet(isPresented: $isAdding) {
            _ColorPicker { color in
                colorItems.append(ColorItem(color))
            }
        }
        .sheet(item: $editingItem) { item in
            _ColorPicker { color in
                if let index = colorItems.firstIndex(where: { $0.id == item.id }) {
                    colorItems[index] = ColorItem(color)
                }
            }
        }
    }
    
    var buttons: some View {
        Group {
            if isRemoving {
                 Button("Done") {
                     isRemoving = false
                }
                
            } else {
                Button("Add color") {
                    isAdding = true
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
                            .onTapGesture {
                                if isRemoving {
                                    colorItems.removeAll { $0.id == item.id }
                                } else {
                                    editingItem = item
                                }
                            }
                        if isRemoving {
                            Image(systemName: "xmark")
                                .resizable()
                                .foregroundColor(.white)
                                .frame(width: 20, height: 20)
                        }
                        
                    }
                }
            }
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

fileprivate struct _ColorPicker: UIViewControllerRepresentable {
    
    let colorSelected: (Color) -> Void
    let delegate = _ColorPickerDelegateAdapter()
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = UIColorPickerViewController()
        delegate.colorSelected = colorSelected
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

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SettingsView(setting: Setting.simulator)
        }
    }
}


fileprivate struct ColorItem: Identifiable, Equatable {
    let id = UUID()
    let color: Color
    
    init(_ color: Color) {
        self.color = color
    }
}
