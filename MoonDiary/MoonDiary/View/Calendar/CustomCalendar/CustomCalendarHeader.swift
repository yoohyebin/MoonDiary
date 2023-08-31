//
//  customCalendarHeader.swift
//  MoonDiary
//
//  Created by hyebin on 2023/08/24.
//

import SwiftUI

struct CustomCalendarHeader: View {
    @Binding var currentDate: Date
    @Binding var isShowPicker: Bool
    
    private let calendar = Calendar.current
    
    private var yearBinding: Binding<Int> {
        Binding<Int>(
            get: {
                calendar.component(.year, from: currentDate)
            },
            set: {
                let newDate = calendar.date(bySetting: .year, value: $0, of: currentDate)!
                currentDate = newDate
            }
        )
    }
        
    private var monthBinding: Binding<Int> {
        Binding<Int>(
            get: {
                calendar.component(.month, from: currentDate)
            },
            set: {
                let newDate = calendar.date(bySetting: .month, value: $0, of: currentDate)!
                currentDate = newDate
            }
        )
    }
    
    var body: some View {
        HStack {
            Button(
                action: {
                    isShowPicker.toggle()
                }, label: {
                    Text(currentDate.dateToMonthYear())
                        .font(.system(size: 17, weight: .semibold))
                    Image(systemName: isShowPicker ? Images.chevronDown : Images.chevronRight)
                        .font(.system(size: 17, weight: .semibold))
                }
            )
            
            Spacer(minLength: 0)
            
            Button(
                action: {
                    currentDate = Calendar.current.date(byAdding: .month, value: -1, to: currentDate)!
                }, label: {
                    Image(systemName: Images.chevronLeft)
                }
            )
            .padding(.trailing, 28)
            
            Button(
                action: {
                    currentDate = Calendar.current.date(byAdding: .month, value: 1, to: currentDate)!
                }, label: {
                    Image(systemName: Images.chevronRight)
                }
            )
            .padding(.trailing, 12)
        }
        .padding(.leading, 8)
        .padding(.bottom, 13)
    }
}
