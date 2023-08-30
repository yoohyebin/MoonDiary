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
            //FIXME: image -> enum
            Image("Moon_dark")
                .resizable()
            //FIXME: padding으로
                .frame(maxWidth: 240, maxHeight: 240)
                .opacity(phase+0.2)
            
            LunarPhaseView(phase:phase)
                .padding(-2)
            //FIXME: padding으로
                .frame(maxWidth: 240, maxHeight: 240)
        }
    }
}

struct MoonView_Previews: PreviewProvider {
    static var previews: some View {
        MoonView(phase: 0.2)
    }
}
