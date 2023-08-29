//
//  CalendarDateButtonView.swift
//  MoonDiary
//
//  Created by hyebin on 2023/08/29.
//

import SwiftUI

struct CalendarDateButtonView: View {
    let date: Date
    let phase: Double?
    let currentMode: Bool
    let cellHeight: CGFloat
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            ZStack {
                if date.date() == Date().date() {
                    Circle()
                        .frame(maxWidth: 40, maxHeight: 40)
                        .foregroundColor(.labelColor)
                    
                    Text(date.dateToDay())
                        .foregroundColor(currentMode ? .backgroundColorDark : .backgroundColor )
                        .font(.system(size: 13))
                        .frame(maxWidth: .infinity)
                        .padding(8)
                }else {
                    Text(date.dateToDay())
                        .foregroundColor(.labelColor )
                        .font(.system(size: 13))
                        .frame(maxWidth: .infinity)
                        .padding(8)
                }
            }
            if let phase = phase {
                MoonView(phase: phase)
                    .frame(width: 23, height: 23)
            }else {
                Spacer()
                    .frame(width: 23, height: 23)
            }
        }
        .foregroundColor(.labelColor)
        .frame(maxWidth: .infinity ,maxHeight: .infinity)
        .frame(height: cellHeight)
    }
}
