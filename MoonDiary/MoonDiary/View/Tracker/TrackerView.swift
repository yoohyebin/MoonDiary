//
//  TrackerView.swift
//  MoonDiary
//
//  Created by hyebin on 2023/08/17.
//

import SwiftUI

struct TrackerView: View {
    @State private var dragState = DragState()
    @Binding var date: Date
    @Binding var currentMode: Bool
    @Binding var moonsData: [Date: Double]
    var currentDate: (monthDay: String, day: String){
        let stringDate = date.dateToString().split(separator: " ").map{String($0)}
        return(stringDate[0...1].joined(separator: " "), stringDate[2])
    }
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("\(currentDate.monthDay)")
                        .font(.system(.largeTitle, weight: .bold))
                        .foregroundColor(.labelColor)
                    
                    Text("\(currentDate.day)")
                        .foregroundColor(.labelColor)
                }
                Spacer(minLength: 0)
            }
            
            Spacer(minLength: 0)
            
            HStack {
                Button(
                    action: {
                        date = Calendar.current.date(byAdding: .day, value: -1, to: date)!
                        dragState.progress = moonsData[date] ?? 0.0
                    },
                    label: {
                        Image(systemName: Images.chevronLeft)
                            .foregroundColor(.labelColor)
                    }
                )
                
                Spacer(minLength: 0)
                
                MoonDragView(dragState: $dragState)
                    .onChange(of: date) { newValue in
                        dragState.progress = moonsData[newValue] ?? 0.0
                    }
                    .onAppear(){
                        dragState.progress = moonsData[date] ?? 0.0
                    }
                
                Spacer(minLength: 0)
                
                Button(
                    action: {
                        date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
                        dragState.progress = moonsData[date] ?? 0.0
                    },
                    label: {
                        Image(systemName: Images.chevronRight)
                            .foregroundColor(.labelColor)
                    }
                )
            }
            
            Spacer(minLength: 0)
            
            Button(
                action: {
                    if moonsData[date] == nil {
                        MoonDataManager().addNewMoon((date: date, phase: Double(dragState.progress)))
                        
                    }else {
                        MoonDataManager().updateMoon((date: date, phase: Double(dragState.progress)))
                    }
                    moonsData[date] = Double(dragState.progress)
                }, label: {
                    HStack {
                        Image(systemName: Images.save)
                            .font(.system(size: 17))
                        Text("Save")
                            .font(.system(size: 12))
                    }
                    .foregroundColor(.labelColor)
                    .padding(.vertical, 14)
                    .padding(.horizontal, 20)
                }
            )
            .background(currentMode ? Color.fillsColorDark : Color.fillsColor)
            .cornerRadius(10)
        }
    }
}

