//
//  iOSColorPicker.swift
//  RainyText
//
//  Created by Shayan on 1/12/1402 AP.
//

import SwiftUI

#if os(iOS)
struct iOSColorPicker: UIViewControllerRepresentable {
    
    let color: Color
    var colorPicked: (Color) -> Void
    private let delegate = ColorPickerDelegateAdapter()
    
    func makeUIViewController(context: Context) -> UIColorPickerViewController {
        let vc = UIColorPickerViewController()
        vc.view.backgroundColor = .systemBackground
        delegate.colorSelected = colorPicked
        vc.delegate = delegate
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIColorPickerViewController, context: Context) {
        uiViewController.selectedColor = UIColor(color)
    }
}


fileprivate class ColorPickerDelegateAdapter: NSObject, UIColorPickerViewControllerDelegate {
    
    var colorSelected: ((Color) -> Void)?
    
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        if !continuously {
            colorSelected?(Color(uiColor: color))
        }
    }
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        viewController.dismiss(animated: true)
    }
}
#endif
