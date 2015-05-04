

import UIKit

class HypnonsisView: UIView {

    private let colors = [UIColor.redColor(),
        UIColor.orangeColor(),
        UIColor.yellowColor(),
        UIColor.greenColor(),
        UIColor.blueColor(),
        UIColor.purpleColor()
    ]
    
    private var radiusOffset: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    private var timer: NSTimer?
    private var distanceBtwnCircles: CGFloat = 20
    private var circleLineThickness: CGFloat = 10
    private var smallsetCircleColorIndex: Int = 0
    private var centralImage: UIImage? = UIImage(named: "bill_up_close.png")
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor  = UIColor.clearColor()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func timerFired(timer: NSTimer) {
        radiusOffset += 1.0

        if radiusOffset > distanceBtwnCircles {
            radiusOffset = 0
            
            smallsetCircleColorIndex--
            if smallsetCircleColorIndex < 0 {
                    smallsetCircleColorIndex = colors.count - 1
            }
        }
    }
    
    override func didMoveToSuperview() {
        if superview != nil {
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0/45.0,
                target: self,
                selector: "timerFired:", // <-- name of method to call when fired
                userInfo: nil,
                repeats: true)
        }
    }
    
    override func removeFromSuperview() {
        timer?.invalidate()
        timer = nil
        
        super.removeFromSuperview()
    }
    
    override func drawRect(rect: CGRect) {
        let bounds = self.bounds
        
        // get center of bounds rectangle
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        
        // max radius is 1/2 hypotenus of the screen
        let maxRadius: CGFloat = 0.5 * hypot(bounds.width, bounds.height)
        
        // draw a bunch of concentric circles
        var currentIndex = smallsetCircleColorIndex
        for var radius:CGFloat = 0; radius < maxRadius; radius += distanceBtwnCircles {
            
            let path = UIBezierPath()
            path.addArcWithCenter(center,
                radius: (radius + radiusOffset),
                startAngle: 0,
                endAngle: CGFloat(M_PI * 2),
                clockwise: true)
            
            path.lineWidth = circleLineThickness
            
            let currentColor = colors[currentIndex]
            currentColor.setStroke()
            path.stroke()
            
            // update index
            currentIndex++
            currentIndex = (currentIndex % colors.count)
        }
        
        // set central image
        let imageSize: CGFloat = 200
        let centralImageOriginX = bounds.midX - (imageSize/2)
        let centalImageOriginY = bounds.midY - (imageSize/2)
        let centralImageRect = CGRect(x: centralImageOriginX, y: centalImageOriginY, width: imageSize, height: imageSize)
        
        centralImage?.drawInRect(centralImageRect)
    }
}
