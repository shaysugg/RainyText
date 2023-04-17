//
//  AppSetting.swift
//  RainyText
//
//  Created by Shayan on 1/28/1402 AP.
//

import Foundation


class AppSetting: ObservableObject {
    @Published private(set) var hideStatusBar: Bool
    @Published private(set) var alwaysOnScren: Bool
    
    init(hideStatusBar: Bool, alwaysOnScren: Bool) {
        self.hideStatusBar = hideStatusBar
        self.alwaysOnScren = alwaysOnScren
    }
    
    func applyChanges(hideStatusBar: Bool? = nil, alwaysOnScren: Bool? = nil) {
        if let hideStatusBar { self.hideStatusBar = hideStatusBar }
        if let alwaysOnScren { self.alwaysOnScren = alwaysOnScren }
    }
}
