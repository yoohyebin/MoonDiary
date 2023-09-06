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
    @State private var selectedDate: Date = {
        var calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: Date())
        return calendar.date(from: components)!.withTimeZone(TimeZone.current)
    }()
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
                    // FIXME: 삼항연산자 -> 함수
                    // 삼항연산자도 결국 함수와 같은 역할을 하니, 하단에 함수와 같이 정리해보는 것은 어떨까요?
                    // 물론 코드 구조가 단순한 경우에는 삼항연산자를 활용해도 괜찮으나,
                    // 코드 구조가 복작한 경우에는 함수로 정리하는 것이 코드 관리 및 유지보수 차원에서 더 좋을 것 같습니다.
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
                    
                    // FIXME: extension + @ViewBuilder
                    // 익스텐션과 뷰빌더를 사용하여 코드를 정리해보는 것은 어떨까요?
                    // 뷰 내부 코드가 간결해저 구조를 확인하기 좋습니다!
                    HStack {
                        Button(
                            action: {
                                selectCurrentDate()
                                currentPage = .tracker
                            },
                            label: {
                                VStack {
                                    Image(systemName: Images.systemMoon)
                                        .padding(.bottom,7)
                                    // FIXME: 폰트 익스텐션 만들기
                                    // 폰트 시스템을 다시 만들까 고민하고 있습니다.
                                    // 시스템 구축 후 피그마에 공유해 드리겠습니다/
                                    // 참고해서 작업 진행해 주세요.
                                        .font(.system(size: 20))
                                    // FIXME: enum
                                    // TabBar와 버튼에 해당하는 텍스트/심볼은 따로 enum으로 관리하는 게 어떨까요?
                                    // 뷰 안에 텍스트로 처리하는 것은 휴먼에러에 취약하다는 단점이 있습니다.
                                    Text("Tracker")
                                        .font(.system(size: 10))
                                }
                                .padding(.horizontal, 42)
                            }
                        )
                        // FIXME: 삼항연산자 -> 함수
                        .opacity(currentPage == .tracker ? 1 : 0.2)
                        .foregroundColor(.labelColor)
                        
                        Spacer(minLength: 0)
                        
                        Button(
                            action: {
                                changeCurrentDate()
                                currentPage = .calendar
                            },
                            label: {
                                VStack {
                                    Image(systemName: Images.systemCalendar)
                                        .padding(.bottom,7)
                                        .font(.system(size: 20))
                                    // FIXME: enum
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
            // FIXME: 삼항연산자 -> 함수
            .background(Image(currentMode ? Images.darkBackground : Images.lightBackground).resizable().ignoresSafeArea())
        }
    }
    
    func selectCurrentDate() {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: Date())
        selectedDate = calendar.date(from: components)!.withTimeZone(TimeZone.current)
    }
    
    func changeCurrentDate() {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: Date())
        currentDate = calendar.date(from: components)!.withTimeZone(TimeZone.current)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
