//
//  ContentView.swift
//  MoonDiary
//
//  Created by hyebin on 2023/08/17.
//

import SwiftUI

enum pages {
    case tracker
    case calendar
}

struct ContentView: View {
    @State private var currentMode = false
    @State private var currentPage: pages = .tracker
    @State private var moveToDisplayView = false
    @State private var selectedDate = Date()
    @State private var showPopupView = false
    @State private var currentDate = Date()
    @State private var moonsData = [Date: Double]()

    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                if showPopupView {
                    Color.black.opacity(0.2)
                        .ignoresSafeArea()
                        .onTapGesture {
                            showPopupView = false
                        }
                        .padding(-16)
                        .zIndex(1)
                    
                    YearMonthPicker(currentDate: $currentDate)
                        .cornerRadius(10)
                        .padding(.top, 160)
                        .zIndex(1)
                }
                
                VStack() {
                    Toggle("", isOn: $currentMode)
                        .padding(.trailing, 16)
                        .tint(currentMode ? .backgroundColorDark : .backgroundColor)
                    
                    if currentPage == .tracker {
                        TrackerView(
                            date: $selectedDate,
                            currentMode: $currentMode,
                            moonsData: $moonsData
                        )
                            .padding(.bottom, 30)
                    }else {
                        CalendarView(
                            currentMode: $currentMode,
                            currentPage: $currentPage,
                            currentDate: $currentDate,
                            selectedDate: $selectedDate,
                            moonsData: $moonsData,
                            moveToDisplayView: $moveToDisplayView,
                            showPopupView: $showPopupView
                        )
                        .navigationBarBackButtonHidden()
                        .padding(.bottom, 30)
                    }
                    
                    HStack {
                        Button(
                            action: {
                                if currentPage != .tracker {
                                    selectedDate = Date()
                                }
                                currentPage = .tracker
                            },
                            label: {
                                VStack {
                                    Image(systemName: "moon.fill")
                                        .padding(.bottom,7)
                                        .font(.system(size: 20))
                                    Text("Tracker")
                                        .font(.system(size: 10))
                                }
                                .padding(.horizontal, 42)
                            }
                        )
                        .opacity(currentPage == .tracker ? 1 : 0.2)
                        .foregroundColor(.labelColor)
                        
                        Spacer(minLength: 0)
                        
                        Button(
                            action: {currentPage = .calendar},
                            label: {
                                VStack {
                                    Image(systemName: "calendar")
                                        .padding(.bottom,7)
                                        .font(.system(size: 20))
                                    Text("Calendar")
                                        .font(.system(size: 10))
                                }
                                .padding(.horizontal, 42)
                            }
                        )
                        .opacity(currentPage == .calendar ? 1 : 0.4)
                        .foregroundColor(.labelColor)
                    }
                    
                    NavigationLink (
                        isActive: $moveToDisplayView,
                        destination: {
                            DisplayView(
                                currentMode: $currentMode,
                                displayData: MoonDataManager().readDisplayMoon(currentDate.dateToYearMonth())
                            )
                            .navigationBarBackButtonHidden()
                        },
                        label: {EmptyView()}
                    )
                }
            }
            .onAppear() {
//                MoonDataManager().deleteAll()
                moonsData = MoonDataManager().readMoonData(currentDate.dateToYearMonth())
            }
            .onChange(of: currentDate) { _ in
                moonsData = MoonDataManager().readMoonData(currentDate.dateToYearMonth())
            }
            .ignoresSafeArea()
            .padding()
            .background(Image(currentMode ? "Dark" : "Light").resizable().ignoresSafeArea())
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
