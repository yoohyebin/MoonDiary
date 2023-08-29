//
//  MoonView.swift
//  MoonDiary
//
//  Created by hyebin on 2023/08/27.
//

import SwiftUI

struct MoonDragView: View {
    @Binding var dragState: DragState
    @State private var lastProgress: CGFloat = 0.0 // Store the last progress value
    
    var body: some View {
        ZStack {
            Image("Moon")
                .resizable()
                .frame(maxWidth: 240, maxHeight: 240)
                .opacity(dragState.progress+0.2)
            
            LunarPhaseView(phase: Double(dragState.progress))
                .frame(maxWidth: 240, maxHeight: 240)
        }
        .padding(16)
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { value in
                    handleDraggingChanged(value: value)
                }
                .onEnded { value in
                    handleDraggingEnded(value: value)
                }
        )
    }
    
    private func handleDraggingChanged(value: DragGesture.Value) {
        let width = UIScreen.main.bounds.width
        let dragDistance = value.translation.width
        let velocity = value.predictedEndTranslation.width / value.time.timeIntervalSince(value.time)
        
        let progress = max(min(lastProgress + dragDistance / width, 1.0), 0.0) // Add dragDistance instead of subtracting
        dragState.progress = progress
        dragState.isDragging = true
        
        let thresholdVelocity: CGFloat = 300.0
        if abs(velocity) > thresholdVelocity {
            let direction: CGFloat = velocity > 0 ? -1.0 : 1.0 // Invert direction
            let adjustedProgress = progress + (direction * 0.005)
            dragState.progress = max(min(adjustedProgress, 1.0), 0.0)
        }
    }
    
    private func handleDraggingEnded(value: DragGesture.Value) {
        lastProgress = dragState.progress
        dragState.isDragging = false
    }
}
