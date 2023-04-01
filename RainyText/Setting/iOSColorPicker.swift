//
//  iOSColorPicker.swift
//  RainyText
//
//  Created by Shayan on 1/12/1402 AP.
//

import SwiftUI

#if os(iOS)
fileprivate struct iOSColorPicker: UIViewControllerRepresentable {
    
    let color: Color
    var colorPicked: (Color) -> Void
    let delegate = _ColorPickerDelegateAdapter()
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = UIColorPickerViewController()
        vc.selectedColor = UIColor(color)
        delegate.colorSelected = colorPicked
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
