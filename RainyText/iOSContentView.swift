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
    var body: some View {
            RainyTextView()
                .ignoresSafeArea()
                .id(viewID)
                .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                    viewID += 1
                }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            iOSContentView()
        }
        .environmentObject(Setting.simulator)
        
    }
}
#endif
