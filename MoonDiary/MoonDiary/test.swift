//
//  test.swift
//  MoonDiary
//
//  Created by hyebin on 2023/08/18.
//

import SwiftUI

struct test: View {
    @State private var selectedDate = Date()
    @State private var showDatePicker = false
    
    @State private var isPopupVisible = false
    @State private var popupPosition: CGPoint = .zero
    
    var body: some View {
        //        VStack {
        //            Button(
        //                action: {showDatePicker = true},
        //                label: {
        //                    Text("데이트 피커")
        //                }
        //            )
        //            if showDatePicker {
        //            }
        //        }
        
        //        DatePicker("", selection: $selectedDate)
        //            .datePickerStyle(.graphical)
        
        GeometryReader { geometry in
            ZStack {
                VStack(alignment: .center) {
                    Spacer()
                    Button("Show Popup") {
                        isPopupVisible = true
                        
                    }
                    Spacer()
                    
                }
                
                if isPopupVisible {
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()
                        .onTapGesture {
                            isPopupVisible = false
                        }
                    
                    PopupView()
                        .position(
                            CGPoint(x: geometry.frame(in: .global).midX,
                                    y: geometry.frame(in: .global).midY))
                }
            }
        }
        .ignoresSafeArea()
    }
}

struct PopupView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundColor(.white)
            .frame(width: 200, height: 100)
            .overlay(
                Text("Popup Content")
                    .foregroundColor(.black)
            )
    }
}

struct test_Previews: PreviewProvider {
    static var previews: some View {
        test()
    }
}
