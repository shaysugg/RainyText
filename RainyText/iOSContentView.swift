//
//  ContentView.swift
//  RainyText
//
//  Created by Shayan on 12/27/1401 AP.
//
#if os(iOS)
import SwiftUI

struct iOSContentView: View {
    @State private var viewID = 0
    @State private var presentSetting = false
    @EnvironmentObject var setting: Setting
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            RainyTextView()
                .ignoresSafeArea()
                .id(viewID)
                .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                    viewID += 1
                }
            Button {
                presentSetting = true
            } label: {
                Image(systemName: "gearshape.fill")
            }
            .tint(.white)
            .padding()
            
            .sheet(isPresented: $presentSetting) {
                iOSSettingView(setting: setting, isPresented: $presentSetting)
            }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            iOSContentView()
        }
        .environmentObject(Setting.preview)
        
    }
}
#endif
