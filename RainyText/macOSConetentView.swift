//
//  macOSConetentView.swift
//  RainyText
//
//  Created by Shayan on 1/2/1402 AP.
//
#if os(macOS)
import SwiftUI

struct macOSConetentView: View {
    @State private var viewID = 0
    var body: some View {
        
        RainyTextView()
            .id(viewID)
            .onReceive(NotificationCenter.default.publisher(for: NSWindow.didResizeNotification)) { a in
                //TODO: Laggy as shit
                viewID += 1
                print(viewID)
            }
    }
}

struct macOSConetentView_Previews: PreviewProvider {
    static var previews: some View {
        macOSConetentView()
    }
}
#endif
