//
//  YearMonthPicker.swift
//  MoonDiary
//
//  Created by hyebin on 2023/08/24.
//

import SwiftUI

struct YearMonthPicker: View {
    @State private var selectedYear: Int
    @State private var selectedMonth: Int
    @Binding var currentDate: Date
    
    let monthEn = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    init(currentDate: Binding<Date>) {
           let components = Calendar.current.dateComponents([.year, .month], from: currentDate.wrappedValue)
           _selectedYear = State(initialValue: components.year ?? Date().dateToYearMonth().split(separator: " ").map{Int(String($0))!}[0])
           _selectedMonth = State(initialValue: components.month ?? Date().dateToYearMonth().split(separator: " ").map{Int(String($0))!}[1])
           _currentDate = currentDate
       }
    
    var body: some View {
        ZStack {
            HStack {
                Picker("Month", selection: $selectedMonth) {
                    ForEach(1..<13, id: \.self) { month in
                        Text(monthEn[month-1]).tag(month)
                    }
                }
                .pickerStyle(.wheel)
                .accessibilityHidden(true)

                
                Picker("Year", selection: $selectedYear) {
                    ForEach(1900..<2100, id: \.self) { year in
                        Text(String(year)).tag(year)
                    }
                }
                .pickerStyle(.wheel)
            }
        }
        .background(Color.white)
        .onDisappear() {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd"
            currentDate = formatter.date(from: "\(selectedYear)/\(selectedMonth)/\(1)") ?? Date()
        }
    }
}

struct MyPreviewProvider_Previews: PreviewProvider {
    static var previews: some View {
        YearMonthPicker(currentDate: .constant(Date()))
    }
}
