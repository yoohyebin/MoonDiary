//
//  DisplayView.swift
//  MoonDiary
//
//  Created by hyebin on 2023/08/18.
//

import SwiftUI

struct DisplayView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var current = 0
    @State private var isPlaying = false
    @State private var playbackTimer: Timer?
    
    @Binding var currentMode: Bool
    let displayData: [(date: Date, phase: Double)]    
    
    var body: some View {
        VStack {
            HStack(alignment: .center){
                Button(
                    action: {
                        dismiss()
                    }, label: {
                        HStack {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 17, weight: .semibold))
                            Text("Back")
                        }
                        .foregroundColor(.labelColor)
                    }
                )
                
                Toggle("", isOn: $currentMode)
                    .padding(.trailing, 16)
                    .tint(currentMode ? .backgroundColorDark : .backgroundColor)
            }
            
            Spacer(minLength: 0)
            
            HStack {
                Button(
                    action: {
                        if current > 0 {current -= 1}
                    },
                    label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.labelColor)
                    }
                )
                
                Spacer(minLength: 0)
                
                MoonView(phase: displayData[current].phase)
                
                Spacer(minLength: 0)
                
                Button(
                    action: {
                        if current < displayData.count-1 {current += 1}
                    },
                    label: {
                        Image(systemName: "chevron.right")
                            .foregroundColor(.labelColor)
                    }
                )
            }
            .padding(.bottom, 15)
            
            Text(displayData[current].date.dateToMonthDay())
                .font(.system(.largeTitle, weight: .bold))
                .foregroundColor(.labelColor)
            
            Text(displayData[current].date.dateToDate())
                .foregroundColor(.labelColor)
                .padding(.bottom, 52)
            
            Button(
                action: {
                    isPlaying ? stopPlayback() : startPlayback()
                    isPlaying.toggle()
                }, label: {
                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                        .padding(20)
                        .foregroundColor(.labelColor)
                }
            )
            .background(currentMode ? Color.fillsColorDark : Color.fillsColor)
            .cornerRadius(100)
            .padding(.bottom, 92)
        }
        .ignoresSafeArea()
        .padding()
        .background(Image(currentMode ? "Dark" : "Light").resizable().ignoresSafeArea())
        .onAppear() {
            playbackTimer?.invalidate()
        }
    }
    
    private func startPlayback() {
        current = 0
        playbackTimer?.invalidate()
        playbackTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if current < displayData.count - 1 {
                current += 1
            } else {
                stopPlayback()
            }
        }
        RunLoop.current.add(playbackTimer ?? Timer(), forMode: .common)
    }
    
    private func stopPlayback() {
        isPlaying = false
        playbackTimer?.invalidate()
    }
}

//struct DisplayView_Previews: PreviewProvider {
//    static var previews: some View {
//        DisplayView(currentMode: .constant(false), month: "08")
//    }
//}
