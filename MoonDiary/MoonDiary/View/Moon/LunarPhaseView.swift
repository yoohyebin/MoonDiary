//
//  LunarPhaseView.swift
//  MoonDiary
//
//  Created by hyebin on 2023/08/27.
//

import SwiftUI

struct LunarPhaseView: UIViewRepresentable {
    typealias UIViewType = LunarPhaseViewImpl
    let phase: Double
        
    init(phase: Double) {
        self.phase = phase
    }
    
    func makeUIView(context: UIViewRepresentableContext<LunarPhaseView>) -> LunarPhaseViewImpl {
        let view = LunarPhaseViewImpl(
            frame: CGRect.zero
        )
        view.backgroundColor = .clear
        view.phase = phase
        return view
    }
    
    func updateUIView(_ uiView: LunarPhaseViewImpl,
                      context: UIViewRepresentableContext<LunarPhaseView>) {
        uiView.phase = phase
        uiView.setNeedsDisplay()
    }
}

internal final class LunarPhaseViewImpl: UIView {
    var phase: Double = 0.0
    
    override func draw(_ rect: CGRect) {
        let diameter = Double(rect.width)
        let radius = Int(diameter / 2)
        
        if let overlayImage = UIImage(named: Images.moon) {
            let renderer = UIGraphicsImageRenderer(size: rect.size)
            let maskedImage = renderer.image { context in
                let path = UIBezierPath()
                for Ypos in 0...radius {
                    let Xpos = -sqrt(Double((radius * radius) - Ypos * Ypos))
                    let Rpos = 2 * Xpos
                    var Xpos1 = 0.0
                    var Xpos2 = 0.0
                    if (phase < 0.5) {
                        Xpos1 = Xpos * -1
                        Xpos2 = Double(Rpos) - (2.0 * phase * Double(Rpos)) - Double(Xpos)
                    } else {
                        Xpos1 = Xpos
                        Xpos2 = Double(Xpos) - (2.0 * phase * Double(Rpos)) + Double(Rpos)
                    }

                    let pW1 = CGPoint(x: CGFloat(Xpos1 + Double(radius)), y: CGFloat(Double(radius) - Double(Ypos)))
                    let pW2 = CGPoint(x: CGFloat(Xpos2 + Double(radius)), y: CGFloat(Double(radius) - Double(Ypos)))
                    let pW3 = CGPoint(x: CGFloat(Xpos1 + Double(radius)), y: CGFloat(Double(radius) + Double(Ypos)))
                    let pW4 = CGPoint(x: CGFloat(Xpos2 + Double(radius)), y: CGFloat(Double(radius) + Double(Ypos)))

                    path.move(to: pW1)
                    path.addLine(to: pW2)
                    path.addLine(to: pW4)
                    path.addLine(to: pW3)
                    path.close()
                }
                
                if let context = UIGraphicsGetCurrentContext() {
                    context.addPath(path.cgPath)
                    context.clip()
                    
                    overlayImage.draw(in: rect)
                }
            }

            maskedImage.draw(in: rect)
        }
    }
}
