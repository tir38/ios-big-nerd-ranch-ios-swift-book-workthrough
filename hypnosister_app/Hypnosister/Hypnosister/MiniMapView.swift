
import UIKit

class MiniMapView: UIView {

    
    private var relativeX: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    private var relativeY: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    private var relativeHeight: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    private var relativeWidth: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.7)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func updateWithScrollView(sv: UIScrollView) {
        relativeX = sv.contentOffset.x / sv.contentSize.width
        relativeY = sv.contentOffset.y / sv.contentSize.height
        relativeWidth = sv.bounds.width / sv.contentSize.width
        relativeHeight = sv.bounds.height / sv.contentSize.height
    }
    
    override func drawRect(rect: CGRect) {
        let bounds = self.bounds
        
        // compute values for rect
        let x = bounds.width * relativeX
        let y = bounds.height * relativeY
        let width = bounds.width * relativeWidth
        let height = bounds.height * relativeHeight
        
        // create rect
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: x, y: y))
        path.addLineToPoint(CGPoint(x: x+width, y: y))
        path.addLineToPoint(CGPoint(x: x+width, y: y+height))
        path.addLineToPoint(CGPoint(x: x, y: y+height))
        path.closePath()
        
        
        // fill rect
        UIColor.grayColor().colorWithAlphaComponent(0.8).setFill()
        path.fill()
    }
    
    
    
}
