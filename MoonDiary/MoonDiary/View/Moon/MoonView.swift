//
//  MoonView.swift
//  MoonDiary
//
//  Created by hyebin on 2023/08/28.
//

import SwiftUI

struct MoonView: View {
    let phase: Double
    let size: CGSize
    
    var body: some View {
        ZStack {
            Image(Images.moon)
                .resizable()
                .frame(maxWidth: 240, maxHeight: 240)
            
            MoonActivityIndicatorView(frameSize: size, phase: phase)
                .frame(maxWidth: size.width, maxHeight: size.height)
                .opacity(phase+0.5)
        }
    }
}

struct MoonView_Previews: PreviewProvider {
    static var previews: some View {
        MoonView(phase: 0.9, size: CGSize(width: 240, height: 240))
    }
}
