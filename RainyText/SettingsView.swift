//
//  SettingsView.swift
//  RainyText
//
//  Created by Shayan on 12/27/1401 AP.
//

import SwiftUI
//
//struct SettingsView: View {
//    @EnvironmentObject var setting: Setting
//    @State private var selectedLetters: Set<Letters>
//    
//    init() {
//        
//        self.selectedLetters = []
//    }
//    var body: some View {
//        Form {
//            ForEach(Letters.allCases, id: \.rawValue) { letter in
//                HStack {
//                    Image(systemName: "circle")
//                    Text(nameOf(letters: letter))
//                }
//            }
//            
//            
//        }
//    }
//    
//    func nameOf(letters: Letters) -> String {
//        switch letters {
//        case .english: return "English"
//        case .arabic: return "Arabic"
//        case .chinese: return "Chinese"
//        case .numbers: return "Numbers"
//        case .symbols: return "Symbols"
//            
//        }
//    }
//}
//
//struct GradientColorPicker: View {
//    
//    struct ColorItem: Identifiable, Equatable {
//        let id = UUID()
//        let color: Color
//        
//        init(_ color: Color) {
//            self.color = color
//        }
//    }
//    
//    @State private var colorItems: [ColorItem] = [ColorItem(.blue), ColorItem(.green)]
//    @State private var isRemoving = false
//    @State private var editingItem: ColorItem?
//    @State private var isAdding = false
//    
//    var body: some View {
//        HStack {
//            colorsRow
//            
//            if isRemoving {
//                Button("Done") { isRemoving = false }
//            } else {
//                plusOrMinusView
//            }
//        }
//        
//        .sheet(isPresented: $isAdding) {
//            _ColorPicker { color in
//                colorItems.append(ColorItem(color))
//            }
//        }
//        .sheet(item: $editingItem) { item in
//            _ColorPicker { color in
//                if let index = colorItems.firstIndex(where: { $0.id == item.id }) {
//                    colorItems[index] = ColorItem(color)
//                }
//            }
//        }
//    }
//    
//    var colorsRow: some View {
//        ScrollView(.horizontal) {
//            ForEach(colorItems) { item in
//                ZStack {
//                    Circle()
//                        .foregroundColor(item.color)
//                        .frame(width: 70, height: 80)
//                        .onTapGesture {
//                            if isRemoving {
//                                colorItems.removeAll { $0.id == item.id }
//                            } else {
//                                editingItem = item
//                            }
//                        }
//                    if isRemoving {
//                        Image(systemName: "xmark")
//                            .resizable()
//                            .foregroundColor(.white)
//                            .frame(width: 20, height: 20)
//                    }
//                    
//                }
//            }
//        }
//    }
//    
//    var plusOrMinusView: some View {
//        VStack {
//            Button {
//                isAdding = true
//            } label: {
//                Image(systemName: "plus")
//                    .resizable()
//                    .frame(width: 30, height: 30)
//                
//            }
//            
//            Button {
//                isRemoving = true
//            } label: {
//                Image(systemName: "minus")
//                    .resizable()
//                    .frame(width: 30, height: 30)
//            }
//        }
//        .buttonStyle(.bordered)
//    }
//}
//
//fileprivate struct _ColorPicker: UIViewControllerRepresentable {
//    
//    let colorSelected: (Color) -> Void
//    let delegate = _ColorPickerDelegateAdapter()
//    
//    func makeUIViewController(context: Context) -> some UIViewController {
//        let vc = UIColorPickerViewController()
//        delegate.colorSelected = colorSelected
//        vc.delegate = delegate
//        return vc
//    }
//    
//    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//        
//    }
//}
//
//NSColorp
//
//fileprivate class _ColorPickerDelegateAdapter: NSObject, UIColorPickerViewControllerDelegate {
//    
//    var colorSelected: ((Color) -> Void)?
//    
//    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
//        if !continuously {
//            colorSelected?(Color(uiColor: color))
//            viewController.dismiss(animated: true)
//        }
//    }
//    
//    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
//        print("finished")
//    }
//}
//
//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            GradientColorPicker()
//                .previewLayout(.fixed(width: 300, height: 200))
//            SettingsView()
//                .environmentObject(Setting(rainColors: [.blue], letters: [.chinese], orientation: .portrait))
//        }
//    }
//}
