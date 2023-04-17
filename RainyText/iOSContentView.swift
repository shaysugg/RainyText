//
//  ContentView.swift
//  RainyText
//
//  Created by Shayan on 12/27/1401 AP.
//
#if os(iOS)
import SwiftUI
import RainyTextView

struct iOSContentView: View {
    @State private var viewID = 0
    @State private var presentSetting = false
    @State private var isSettingButtonHidden = false
    @EnvironmentObject var setting: RainyTextView.Setting
    @EnvironmentObject var appSetting: AppSetting
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            RainyTextView()
                .ignoresSafeArea()
                .id(viewID)
                .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                    viewID += 1
                }
            SettingButton(isHidden: $isSettingButtonHidden) {
                presentSetting = true
            }
        }
        .statusBarHidden(appSetting.hideStatusBar)
        .sheet(isPresented: $presentSetting) {
            iOSSettingView(rainSetting: setting, appSetting: appSetting, isPresented: $presentSetting)
        }
        .onTapGesture {
            isSettingButtonHidden = false
        }
    }
}


struct SettingButton: View {
    @Binding var isHidden: Bool
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "gearshape.fill")
                .resizable()
                .frame(width: 25, height: 25)
        }
        .tint(.white)
        .padding()
        .opacity(isHidden ? 0 : 1)
        .animation(.default, value: isHidden)
        .onAppear(perform: hideWithDelay)
        .onChange(of: isHidden) { hidden in
            if !hidden { hideWithDelay() }
        }
    }
    
    func hideWithDelay() {
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) {
            isHidden = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            iOSContentView()
        }
        .environmentObject(AppSetting.preview)
        .environmentObject(RainyTextView.Setting.preview)
        
    }
}
#endif
