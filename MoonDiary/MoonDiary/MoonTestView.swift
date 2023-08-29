////
////  MoonTestView.swift
////  MoonDiary
////
////  Created by hyebin on 2023/08/24.
////
//
//import SwiftUI
//
//struct MoonTest: View {
//    @State private var dragState = DragState()
//    @State private var lastProgress: CGFloat = 0.0 // Store the last progress value
//    
//    var body: some View {
//        ZStack {
//            Image("Moon")
//                .resizable()
//                .frame(width: 175, height: 175)
//                .opacity(dragState.progress+0.2)
//            
//            LunarPhaseView(phase: Double(dragState.progress))
//                .frame(width: 175, height: 175)
//        }
//        .padding(16)
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
//        let progress = max(min(lastProgress + dragDistance / width, 1.0), 0.0) // Add dragDistance instead of subtracting
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
//        view.backgroundColor = .clear
//        view.phase = phase
//        return view
//    }
//    
//    func updateUIView(_ uiView: LunarPhaseViewImpl,
//                      context: UIViewRepresentableContext<LunarPhaseView>) {
//        uiView.phase = phase
//        uiView.setNeedsDisplay()
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
//        if let overlayImage = UIImage(named: "pngegg") {
//            let renderer = UIGraphicsImageRenderer(size: rect.size)
//            let maskedImage = renderer.image { context in
//                let path = UIBezierPath()
//                for Ypos in 0...radius {
//                    let Xpos = sqrt(Double((radius * radius) - Ypos * Ypos))
//                    let Rpos = 2 * Xpos
//                    var Xpos1 = 0.0
//                    var Xpos2 = 0.0
//                    if (phase < 0.5) {
//                        Xpos1 = Xpos * -1
//                        Xpos2 = Double(Rpos) - (2.0 * phase * Double(Rpos)) - Double(Xpos)
//                    } else {
//                        Xpos1 = Xpos
//                        Xpos2 = Double(Xpos) - (2.0 * phase * Double(Rpos)) + Double(Rpos)
//                    }
//
//                    print("\(phase) \(Xpos1) \(Xpos2)")
//                    
//                    let pW1 = CGPoint(x: CGFloat(Xpos1 + Double(radius)), y: CGFloat(Double(radius) - Double(Ypos)))
//                    let pW2 = CGPoint(x: CGFloat(Xpos2 + Double(radius)), y: CGFloat(Double(radius) - Double(Ypos)))
//                    let pW3 = CGPoint(x: CGFloat(Xpos1 + Double(radius)), y: CGFloat(Double(radius) + Double(Ypos)))
//                    let pW4 = CGPoint(x: CGFloat(Xpos2 + Double(radius)), y: CGFloat(Double(radius) + Double(Ypos)))
//
//                    path.move(to: pW1)
//                    path.addLine(to: pW2)
//                    path.addLine(to: pW4)
//                    path.addLine(to: pW3)
//                    path.close()
//                }
//                
//                if let context = UIGraphicsGetCurrentContext() {
//                    context.addPath(path.cgPath)
//                    context.clip()
//                    
//                    overlayImage.draw(in: rect)
//                }
//            }
//            
//            maskedImage.draw(in: rect)
//        }
//    }
//}
//
//struct MoonTest_Previews: PreviewProvider {
//    static var previews: some View {
//        MoonTest()
//    }
//}
