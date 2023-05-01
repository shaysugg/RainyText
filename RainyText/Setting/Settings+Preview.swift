//
//  Settings+Preview.swift
//  RainyText
//
//  Created by Shayan on 1/28/1402 AP.
//

import Foundation
import RainyTextView

extension AppSetting {
    static let preview = AppSetting(hideStatusBar: true, alwaysOnScren: true)
}

extension RainyTextView.Setting {
    static let preview = RainyTextView.Setting(rainColors: [.black, .green], letters: [.english, .chinese], backgroundColor: .black, rainHeight: 0.5)
}
