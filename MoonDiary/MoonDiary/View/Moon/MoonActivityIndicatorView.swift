//
//  MoonActivityIndicatorView.swift
//  MoonDiary
//
//  Created by hyebin on 2023/09/01.
//

import SwiftUI

struct MoonActivityIndicatorView: UIViewRepresentable {
    var frameSize: CGSize
    var phase: CGFloat

    func makeUIView(context: Context) -> MoonActivityIndicator {
        let indicator = MoonActivityIndicator(frameSize: frameSize, phase: phase)
        indicator.startAnimating()
        return indicator
    }

    func updateUIView(_ uiView: MoonActivityIndicator, context: Context) {
        uiView.phase = phase
    }
}

class MoonActivityIndicator: UIView {
    private var animationCycleDuration: Double = 2.0
    private var fillColor: UIColor = UIColor.black
    private var fillBackgroundColor: UIColor = UIColor.clear

    private var pathLayer: CAShapeLayer?
    private var displayLink: CADisplayLink?
    
    private var imageLayer: CALayer?
    private var image: UIImage?
    
    var phase: CGFloat = 0.0

    convenience init(frameSize: CGSize, phase: CGFloat) {
        self.init(frame: CGRect(origin: .zero, size: frameSize))
        self.phase = phase
        self.image = UIImage(named: Images.moonDark)
        setUpLayers()
        startAnimating()
    }

    private func setUpLayers() {
        let contourLayer = CAShapeLayer()
        contourLayer.frame = bounds
        contourLayer.path = UIBezierPath(ovalIn: bounds).cgPath
        contourLayer.fillColor = fillBackgroundColor.cgColor
        layer.addSublayer(contourLayer)

        imageLayer = CALayer()
        imageLayer?.frame = CGRect(x: bounds.minX, y: bounds.minY, width: bounds.width, height: bounds.height)
        imageLayer?.contents = image?.cgImage
        layer.addSublayer(imageLayer!)
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = UIBezierPath(ovalIn: bounds).cgPath
        imageLayer?.mask = maskLayer
    }

    private func updatePathLayer() {
        guard let imageLayer = imageLayer else { return }

        let maskLayer = imageLayer.mask as? CAShapeLayer
        let path = pathAtInterval()
        maskLayer?.path = path
    }

    func startAnimating() {
        displayLink = CADisplayLink(target: self, selector: #selector(handleDisplayLink))
        displayLink?.add(to: .current, forMode: .default)
    }

    @objc private func handleDisplayLink() {
        updatePathLayer()
    }

    private func pathAtInterval() -> CGPath {
        var cycleInterval = phase
        cycleInterval = LogisticCurve.calculateYWithX(x: cycleInterval,
            upperX: CGFloat(animationCycleDuration),
            upperY: CGFloat(animationCycleDuration))
        
        let aPath = UIBezierPath()
        
        let length = layer.bounds.width
        let halfLength = layer.bounds.width / 2.0
        let halfAnimationDuration = CGFloat(animationCycleDuration) / 2.0
        let isFirstHalfOfAnimation = cycleInterval < halfAnimationDuration
        
        aPath.move(to: CGPoint(x: length, y: halfLength))
        aPath.addArc(withCenter: CGPoint(x: halfLength,y: halfLength),
            radius: halfLength,
            startAngle: -CGFloat(Double.pi)/2.0,
            endAngle: CGFloat(Double.pi)/2.0,
            clockwise: isFirstHalfOfAnimation)
        
        let x:CGFloat = length * 0.6667
        var t:CGFloat
        if isFirstHalfOfAnimation {
            t = -(2.0/halfAnimationDuration) * cycleInterval + 1
        } else {
            t = -(2.0/halfAnimationDuration) * (cycleInterval-halfAnimationDuration) + 1
        }
        let controlPointXDistance:CGFloat = halfLength + t * x
        
        aPath.addCurve(to: CGPoint(x: halfLength, y: 0),
                       controlPoint1: CGPoint(x: controlPointXDistance, y: length - 0.05*length),
                       controlPoint2: CGPoint(x: controlPointXDistance, y: 0.05*length))
        aPath.close()
        
        return aPath.cgPath
    }
}

private extension Double {
    func remainingAfterMultiple(multiple:TimeInterval) -> TimeInterval {
        return self - multiple * floor(self/multiple)
    }
}

private class LogisticCurve {
    class func calculateYWithX(x:CGFloat,lowerX:CGFloat = 0, upperX:CGFloat,lowerY:CGFloat = 0, upperY:CGFloat) -> CGFloat {
        let b = -6.0 * (upperX+lowerX) / (upperX-lowerX)
        let m = (6.0-b)/upperX
        let scaledX = m * x + b
        let y = 1.0 / (1.0 + pow(CGFloat(M_E), -scaledX))
        let yScaled = (upperY - lowerY) * y + lowerY
        
        return yScaled
    }
}
