//
//  MoonView.swift
//  MoonDiary
//
//  Created by hyebin on 2023/08/28.
//

import SwiftUI

struct MoonView: View {
    let phase: Double
    
    var body: some View {
        ZStack {
            Image("Moon_dark")
                .resizable()
                .frame(maxWidth: 240, maxHeight: 240)
                .opacity(phase+0.2)
            
            LunarPhaseView(phase:phase)
                .padding(-2)
                .frame(maxWidth: 240, maxHeight: 240)
        }
    }
}

struct MoonView_Previews: PreviewProvider {
    static var previews: some View {
        MoonView(phase: 0.2)
    }
}
