//
//  AppSetting.swift
//  RainyText
//
//  Created by Shayan on 1/28/1402 AP.
//

import Foundation
import RainyTextView
import SwiftUI

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

class Setting: ObservableObject {
    @ObservedObject private(set) var app: AppSetting
    @ObservedObject private(set) var rain: RainyTextView.Setting
    
    init(app: AppSetting, rain: RainyTextView.Setting) {
        self.app = app
        self.rain = rain
    }
    
    static func load() -> Setting {
        Setting(app: AppSetting.load(),
                rain: RainyTextView.Setting.load())
    }
    
    func save() {
        app.save()
        rain.save()
    }
}
