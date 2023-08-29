//
//  MoonTest.swift
//  MoonDiary
//
//  Created by hyebin on 2023/08/24.
//

import SwiftUI

//struct MoonTest: View {
//    struct DragState {
//        var isDragging: Bool = false
//        var progress: CGFloat = 0.0
//    }
//    
//    @State private var dragState = DragState()
//    @State private var lastProgress: CGFloat = 0.0 // Store the last progress value
//    
//    var body: some View {
//        VStack {
//            LunarPhaseView(phase: Double(dragState.progress))
//                .frame(width: 175, height: 175)
//                .padding([.bottom], 16)
//                .padding([.leading, .trailing], 90)
//        }
//        .padding(16)
//        .background(Color.gray)
//        .gesture(
//            DragGesture(minimumDistance: 0)
//                .onChanged { value in
//                    handleDraggingChanged(value: value)
//                }
//                .onEnded { value in
//                    handleDraggingEnded(value: value)
//                }
//        )
//    }
//    
//    private func handleDraggingChanged(value: DragGesture.Value) {
//        let width = UIScreen.main.bounds.width
//        let dragDistance = value.translation.width
//        let velocity = value.predictedEndTranslation.width / value.time.timeIntervalSince(value.time)
//        
//        let progress = max(min(lastProgress - dragDistance / width, 1.0), 0.0) // Subtract dragDistance
//        dragState.progress = progress
//        dragState.isDragging = true
//        
//        let thresholdVelocity: CGFloat = 300.0
//        if abs(velocity) > thresholdVelocity {
//            let direction: CGFloat = velocity > 0 ? -1.0 : 1.0 // Invert direction
//            let adjustedProgress = progress + (direction * 0.005)
//            dragState.progress = max(min(adjustedProgress, 1.0), 0.0)
//        }
//    }
//
//
//    
//    private func handleDraggingEnded(value: DragGesture.Value) {
//        lastProgress = dragState.progress
//        dragState.isDragging = false
//    }
//}
//
//struct LunarPhaseView: UIViewRepresentable {
//    typealias UIViewType = LunarPhaseViewImpl
//    let phase: Double
//        
//    init(phase: Double) {
//        self.phase = phase
//    }
//    
//    func makeUIView(context: UIViewRepresentableContext<LunarPhaseView>) -> LunarPhaseViewImpl {
//        let view = LunarPhaseViewImpl(
//            frame: CGRect.zero
//        )
//        view.phase = phase
//        return view
//    }
//    
//    func updateUIView(_ uiView: LunarPhaseViewImpl,
//                      context: UIViewRepresentableContext<LunarPhaseView>) {
//        uiView.phase = phase // Update the phase value
//        uiView.setNeedsDisplay() // Trigger a redraw
//    }
//}
//
//internal final class LunarPhaseViewImpl: UIView {
//    var phase: Double = 0.0
//    
//    override func draw(_ rect: CGRect) {
//        let diameter = Double(rect.width)
//        let radius = Int(diameter / 2)
//        
//        for Ypos in 0...radius {
//            let Xpos = sqrt(Double((radius * radius) - Ypos * Ypos))
//            
//            let pB1 = CGPoint(x: CGFloat(Double(radius) - Xpos), y: CGFloat(Double(Ypos) + Double(radius)))
//            let pB2 = CGPoint(x: CGFloat(Double(radius) + Xpos), y: CGFloat(Double(Ypos) + Double(radius)))
//
//            let pB3 = CGPoint(x: CGFloat(Double(radius) - Xpos), y: CGFloat(Double(radius) - Double(Ypos)))
//            let pB4 = CGPoint(x: CGFloat(Double(radius) + Xpos), y: CGFloat(Double(radius) - Double(Ypos)))
//
//            let path = UIBezierPath()
//            path.move(to: pB1)
//            path.addLine(to: pB2)
//
//            path.move(to: pB3)
//            path.addLine(to: pB4)
//
//            UIColor.blue.setStroke()
//            path.stroke()
//            
//            let Rpos = 2 * Xpos
//            var Xpos1 = 0.0
//            var Xpos2 = 0.0
//            if (phase < 0.5) {
//                Xpos1 = Xpos * -1
//                Xpos2 = Double(Rpos) - (2.0 * phase * Double(Rpos)) - Double(Xpos)
//            } else {
//                Xpos1 = Xpos
//                Xpos2 = Double(Xpos) - (2.0 * phase * Double(Rpos)) + Double(Rpos)
//            }
//
//            let pW1 = CGPoint(x: CGFloat(Xpos1 + Double(radius)), y: CGFloat(Double(radius) - Double(Ypos)))
//            let pW2 = CGPoint(x: CGFloat(Xpos2 + Double(radius)), y: CGFloat(Double(radius) - Double(Ypos)))
//            let pW3 = CGPoint(x: CGFloat(Xpos1 + Double(radius)), y: CGFloat(Double(radius) + Double(Ypos)))
//            let pW4 = CGPoint(x: CGFloat(Xpos2 + Double(radius)), y: CGFloat(Double(radius) + Double(Ypos)))
//
//            let path2 = UIBezierPath()
//            path2.move(to: pW1)
//            path2.addLine(to: pW2)
//
//            path2.move(to: pW3)
//            path2.addLine(to: pW4)
//
//            UIColor.black.setStroke()
//            path2.lineWidth = 2.0
//            path2.stroke()
//        }
//    }
//}
//
//struct MoonTest_Previews: PreviewProvider {
//    static var previews: some View {
//        MoonTest()
//    }
//}
