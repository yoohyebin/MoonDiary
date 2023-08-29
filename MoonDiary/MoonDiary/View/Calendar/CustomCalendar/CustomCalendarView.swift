//
//  CustomCalendarView.swift
//  MoonDiary
//
//  Created by hyebin on 2023/08/18.
//

import SwiftUI

struct CustomCalendarView: View {
    @State var selectMonth: Date = Date()
    @Binding var currentDate: Date
    @Binding var selectedDate: Date
    @Binding var moonsData: [Date: Double]
    @Binding var showPopupView: Bool
    @Binding var currnetMode: Bool
    
    private let calendar = Calendar.current
    
    private var currentMonthYear: String  {
        currentDate.dateToMonthYear()
    }
    
    private var firstDayOfMonth: Date {
        calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate))!
    }
        
    private var numberOfDaysInMonth: Int {
        calendar.range(of: .day, in: .month, for: firstDayOfMonth)!.count
    }
        
    private var numberOfWeeks: Int {
        return calendar.range(of: .weekOfMonth, in: .month, for: firstDayOfMonth)!.count
    }
        
    private var weekdays: [String] {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        return formatter.shortWeekdaySymbols
    }
    
    var body: some View {
        ZStack {
            VStack {
                CustomCalendarHeader(currentDate: $currentDate, isShowPicker: $showPopupView)
                
                HStack {
                    ForEach(weekdays, id: \.self) { weekday in
                        Text(weekday)
                            .frame(maxWidth: .infinity)
                            .font(.system(size: 13, weight: .semibold))
                    }
                }
                
                VStack {
                    ForEach(0..<numberOfWeeks, id: \.self) { week in
                        HStack {
                            ForEach(0..<7, id: \.self) { day in
                                let date = dayText(forWeek: week, day: day)
                                let maxButtonHeight = 390 / CGFloat(numberOfWeeks) - 16
                                
                                if calendar.isDate(date, equalTo: firstDayOfMonth, toGranularity: .month) {
                                    Button(
                                        action: {
                                            selectedDate = date
                                        }, label: {
                                            CalendarDateButtonView(
                                                date: date,
                                                phase: moonsData[date],
                                                maxHeight: maxButtonHeight,
                                                currentMode: currnetMode
                                            )
                                                .padding(.bottom, 12)
                                        }
                                    )
                                    .disabled(showPopupView)
                                } else {
                                    Spacer()
                                        .frame(maxWidth: 50, maxHeight: maxButtonHeight)
                                        .padding(.horizontal, 4)
                                }
                            }
                        }
                    }
                }
                .frame(maxHeight: 390)
                
            }
        }
    }
    
    private func dayText(forWeek week: Int, day: Int) -> Date {
        var dateComponents = calendar.dateComponents([.year, .month, .day], from: firstDayOfMonth)
        dateComponents.day! += ((week * 7) + day - calendar.component(.weekday, from: firstDayOfMonth) + 1)

        return calendar.date(from: dateComponents)!
    }
}

struct CalendarDateButtonView: View {
    let date: Date
    let phase: Double?
    let maxHeight: CGFloat
    let currentMode: Bool
    
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
    }
}
