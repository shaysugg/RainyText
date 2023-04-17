//
//  ContentView.swift
//  RainyText
//
//  Created by Shayan on 12/26/1401 AP.
//

import SwiftUI

let characterSize: CGFloat = 15

public struct RainyTextView: View {
    @EnvironmentObject var setting: Setting
    
    public init() {}
    
    public var body: some View {
        GeometryReader { geo in
            ZStack {
                setting.backgroundColor
                HStack(spacing: 0) {
                    ForEach(0..<Int(geo.size.width / characterSize), id: \.self) { index in
                        GradientColumn(delay: Double.random(in: 0...6))
                    }
                }
            }
        }
    }
}

struct GradientColumn: View {
    @EnvironmentObject var setting: RainyTextView.Setting
    @State var gradientOffset: CGFloat = 0
    let gradientHeight: CGFloat = 200
    var delay: Double = 0
    
    
    var colors: [Color] { setting.rainColors }
    
    
    var body: some View {
        
        GeometryReader { geo in
            
            VStack {
                ZStack {
                    Color.clear //don't ask me why
                    
                    LinearGradient(colors: colors, startPoint: .top, endPoint: .bottom)
                        .frame(height: gradientHeight)
                        .offset(y:  -( geo.size.height / 2 + gradientHeight ) + gradientOffset)
                        .animation(
                            .linear(duration: geo.size.height / 150)
                            .delay(delay)
                            .repeatForever(autoreverses: false),
                            value: gradientOffset
                        )
                    
                    
                        .mask {
                            ForEach(0..<Int(geo.size.height / characterSize), id: \.self) { _ in
                                RandomCharacterText()
                            }
                        }
                }
            }
            .onAppear {
                gradientOffset = geo.size.height + gradientHeight + gradientHeight / 2 
            }
        }
        
    }
    
    
}


struct RandomCharacterText: View {
    @EnvironmentObject var setting: RainyTextView.Setting
    
    var body: some View {
        Text(RainyTextView.Letters.generateRandomCharacter(from: setting.letters))
            .font(.title2)
            .fontWeight(.bold)
            .foregroundColor(.black)
    }
}



struct RainyTextView_Previews: PreviewProvider {
    static var previews: some View {
        RainyTextView()
            .environmentObject(RainyTextView.Setting.preview)
    }
}
