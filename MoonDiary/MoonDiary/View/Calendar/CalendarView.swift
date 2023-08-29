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
    
    var body: some View {
        VStack {
            HStack {
                Text("Calendar")
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
                currnetMode: $currentMode
            )
                .frame(maxWidth: 361)
                .foregroundColor(.labelColor)
            
                .onChange(of: selectedDate) { _ in
                    currentPage = .tracker
                }
            
            Spacer(minLength: 10)
            
            Button(
                action: {
                    moveToDisplayView = true
                }, label: {
                    HStack {
                        Image(systemName: "binoculars.fill")
                            .font(.system(size: 17))
                        Text("View")
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
    }
}
