//
//  RainyTextApp.swift
//  RainyText
//
//  Created by Shayan on 12/26/1401 AP.
//

import SwiftUI
import Combine
import RainyTextView

@main
struct RainyTextApp: App {
    @StateObject var setting = Setting.load()
#if os(iOS)
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    var body: some Scene {
        WindowGroup {
            iOSContentView()
                .environmentObject(setting)
        }
    }
#endif
    
#if os(macOS)
    var body: some Scene {
        WindowGroup {
            macOSConetentView()
                .frame(minWidth: 400, maxWidth: .infinity, minHeight: 400, maxHeight: .infinity)
            .environmentObject(setting)
            
        }
        .windowResizability(.contentMinSize)
        Settings {
            macOSSettingView(setting: setting.rain)
                .frame(width: 500, height: 400)
        }
        .windowResizability(.contentSize)
        .windowToolbarStyle(.unifiedCompact)
        
        
        
    }
#endif
}

#if os(iOS)
fileprivate final class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        switch UIDevice.current.orientation {
        case .unknown:
            return .portrait
        case .portrait:
            return .portrait
        case .portraitUpsideDown:
            return .portraitUpsideDown
        case .landscapeLeft:
            return .landscapeLeft
        case .landscapeRight:
            return .landscapeRight
        case .faceUp:
            return .portrait
        case .faceDown:
            return .portrait
        @unknown default:
            return .portrait
        }
    }
}
#endif

