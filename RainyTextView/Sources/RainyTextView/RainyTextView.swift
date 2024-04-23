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
    @State private var recreateTrigger = 0
    
    public init() {}
    
    public var body: some View {
        GeometryReader { geo in
            ZStack {
                setting.backgroundColor
                HStack(spacing: 0) {
                    ForEach(0..<Int(geo.size.width / characterSize), id: \.self) { index in
                        GradientColumn(setting: setting, delay: Double.random(in: 0...6))    
                    }
                }
            }
        }
        .id(recreateTrigger)
        .onChange(of: setting.lastChangeDate) { _ in
            recreateTrigger += 1
        }
    }
}

struct GradientColumn: View {
    
    typealias RainSpeed = RainyTextView.Setting.RainSpeed
    
    @State var gradientOffset: CGFloat = 0
    var delay: Double = 0
    var colors: [Color]
    var rainHeight: Double
    var speed: RainSpeed
    
    init(setting: RainyTextView.Setting, delay: Double) {
        self.colors = setting.rainColors
        self.delay = delay
        self.rainHeight = setting.rainHeight
        self.speed = setting.rainSpeed
    }
    
    
    var body: some View {
        
        GeometryReader { geo in
            
            VStack {
                ZStack {
                    Color.clear //don't ask me why
                    
                    LinearGradient(colors: colors, startPoint: .top, endPoint: .bottom)
                        .frame(height: rainHeight)
                        .offset(y:  -( (geo.size.height + rainHeight) / 2) + gradientOffset)
                        .animation(
                            .linear(duration: geo.size.height / 150 * slowness)
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
                gradientOffset = geo.size.height + rainHeight
                
            }
        }
    }
    
    private var slowness: Double {
        switch speed {
        case .verySlow: return 3
        case .slow: return 2
        case .medium: return 1
        case .fast: return 0.7
        case .veryFast: return 0.5
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
