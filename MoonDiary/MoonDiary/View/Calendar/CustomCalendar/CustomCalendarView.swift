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
    @Binding var showTrackerView: Bool
    @Binding var currnetMode: Bool
    
    let height: CGFloat
    
    private var calendar: Calendar {
        let calendar = Calendar.current
        return calendar
    }
    
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
    
    private var cellHeight: CGFloat {
        let totalHeight: CGFloat = height
        let verticalSpacing: CGFloat = numberOfWeeks == 5 ? 16 : 20

        let availableHeight = totalHeight - (CGFloat(numberOfWeeks - 1) * verticalSpacing)
        return availableHeight / CGFloat(numberOfWeeks)
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
                    .padding(.bottom, 12)
                
                HStack {
                    ForEach(weekdays, id: \.self) { weekday in
                        Text(weekday)
                            .frame(maxWidth: .infinity)
                            .font(.system(size: 13, weight: .semibold))
                    }
                }
                .padding(.bottom, 4)
                
                VStack {
                    ForEach(0..<numberOfWeeks, id: \.self) { week in
                        HStack {
                            ForEach(1...7, id: \.self) { day in
                                let date = dayText(forWeek: week, day: day)
                                
                                if calendar.isDate(date, equalTo: firstDayOfMonth, toGranularity: .month) {
                                    Button(
                                        action: {
                                            selectedDate = date
                                            showTrackerView = true
                                        }, label: {
                                            CalendarDateButtonView(
                                                date: date,
                                                phase: moonsData[date],
                                                currentMode: currnetMode,
                                                cellHeight: cellHeight
                                            )
                                            .padding(.bottom, 12)
                                        }
                                    )
                                    .disabled(showPopupView)
                                } else {
                                    Spacer()
                                        .frame(maxWidth: 50, maxHeight: 20)
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

        return calendar.date(from: dateComponents)!.withTimeZone(TimeZone.current)
    }
}
