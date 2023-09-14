//
//  CalendarView.swift
//  MoonDiary
//
//  Created by hyebin on 2023/08/17.
//

import SwiftUI

struct CalendarView: View {
    @Binding var currentMode: Bool
    @Binding var currentPage: pages
    @Binding var currentDate: Date
    @Binding var selectedDate: Date
    @Binding var moonsData: [Date: Double]
    @Binding var moveToDisplayView: Bool
    @Binding var showPopupView: Bool
    
    @State private var showTrackerView = false
    
    let padding: CGFloat = 20
    
    var body: some View {
        GeometryReader { prox in
            VStack {
                HStack {
                    Text(Texts.calendar)
                        .font(.system(.largeTitle, weight: .bold))
                        .foregroundColor(.labelColor)
                    Spacer(minLength: 0)
                }
                
                Spacer(minLength: 10)
                
                CustomCalendarView(
                    currentDate: $currentDate,
                    selectedDate: $selectedDate,
                    moonsData: $moonsData,
                    showPopupView: $showPopupView,
                    showTrackerView: $showTrackerView,
                    currnetMode: $currentMode,
                    height: prox.size.height/2 + padding
                )
                .foregroundColor(.labelColor)
                
                .onChange(of: showTrackerView) { _ in
                    currentPage = .tracker
                }
                
                Spacer(minLength: 10)
                
                Button(
                    action: {
                        moveToDisplayView = true
                    }, label: {
                        HStack {
                            Image(systemName: Images.view)
                                .font(.system(size: 17))
                            
                            Text(Texts.view)
                                .font(.system(size: 12))
                        }
                        .padding(.vertical, 14)
                        .padding(.horizontal, 20)
                        .foregroundColor(.labelColor)
                    }
                )
                .opacity(moonsData.isEmpty ? 0.3 : 1)
                .disabled(moonsData.isEmpty)
                .background(currentMode ? Color.fillsColorDark : Color.fillsColor)
                .cornerRadius(10)
            }
            .frame(maxWidth: prox.size.width, maxHeight: prox.size.height-20)
        }
    }
}
