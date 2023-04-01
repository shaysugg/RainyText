//
//  ColorPaletePicker.swift
//  RainyText
//
//  Created by Shayan on 1/11/1402 AP.
//

import Foundation
import Combine
import SwiftUI

#if os(macOS)
class macOSSettingVM: ObservableObject {
    
    @Published var selectedLetters: Set<Letters>
    @Published private(set)var backgroundColor: IdentifiableColor
    @Published private(set)var colorItems: [IdentifiableColor]
    private var editingColor: IdentifiableColor?
    
    
    private var cancellables = Set<AnyCancellable>()
    
    
    init(setting: Setting) {
        self.selectedLetters = setting.letters
        self.backgroundColor = IdentifiableColor(setting.backgroundColor)
        self.colorItems = setting.rainColors.map { IdentifiableColor($0) }
        listernForColorPanelChanges()
    }
    
    func listernForColorPanelChanges() {
        NotificationCenter.default.publisher(for: NSColorPanel.colorDidChangeNotification).sink { [weak self]_ in
            guard let self, let editing = self.editingColor else { return }
            let pickedColor = IdentifiableColor(Color(NSColorPanel.shared.color))
            self.editingColor = pickedColor
            if let index = self.colorItems.firstIndex(of: editing) {
                self.colorItems[index] = pickedColor
            } else if self.backgroundColor == editing {
                self.backgroundColor = pickedColor
            }
        }.store(in: &cancellables)
    }
    
    func presentPickerIfNeeded() {
        NSColorPanel.shared.orderFront(nil)
    }
    
    func addNewColor() {
        presentPickerIfNeeded()
        let newColor = IdentifiableColor(.red)
        colorItems.append(newColor)
        editingColor = newColor
    }
    
    func edit(color: IdentifiableColor) {
        presentPickerIfNeeded()
        editingColor = color
    }
    
    func remove(color: IdentifiableColor) {
        guard colorItems.count > 1 else { return }
        colorItems.removeAll { $0.id == color.id }
    }
}
#endif
