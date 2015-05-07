
import UIKit

@IBDesignable
class DrawView: UIView {

    var currentLines = [NSValue:Line]()
    var finishedLines = [Line]()
    
    // MARK: private methods
    private func strokeLine(line: Line) {
        let path = UIBezierPath()
        path.lineWidth = 10
        path.lineCapStyle = kCGLineCapRound
        
        path.moveToPoint(line.begin)
        path.addLineToPoint(line.end)
        path.stroke()
    }
    
    // MARK: parent overrides
    override func drawRect(rect: CGRect) {
        // draw finished lines
        UIColor.blackColor().setStroke()
        for line in finishedLines {
            strokeLine(line)
        }
        
        // draw current lines
        for (_, currentLine) in currentLines {
            UIColor.redColor().setStroke()
            strokeLine(currentLine)
        }
    }
    
    override func prepareForInterfaceBuilder() {
        backgroundColor = UIColor.blueColor()
        finishedLines = [Line(begin: CGPoint(x: 15, y: 40), end: CGPoint(x: 15, y: 630)),
            Line(begin: CGPoint(x: 350, y: 40), end: CGPoint(x: 350, y: 630))]
    }
}

extension DrawView {
    // MARK: handle touch events
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        for touch in touches as! Set<UITouch> {
            // get location in this view's coordinate system
            let location = touch.locationInView(self)
            let newLine = Line(begin: location, end: location)
            let key = NSValue(nonretainedObject: touch)
            currentLines[key] = newLine
        }
        setNeedsDisplay()
    }

    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        for touch in touches as! Set<UITouch> {
            let location = touch.locationInView(self)
            
            // find current line by touch key
            let key = NSValue(nonretainedObject: touch)
            if var line = currentLines[key] {
                line.end = touch.locationInView(self)
                currentLines[key] = line
            }
        }
        setNeedsDisplay()
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        // finish current line by setting end and saving to finished lines
        
        for touch in touches as! Set<UITouch> {
            let location = touch.locationInView(self)
            
            let key = NSValue(nonretainedObject: touch)
            if var line = currentLines[key] {
                line.end = location
                finishedLines.append(line)
                currentLines.removeValueForKey(key)
            }
        }
        setNeedsDisplay()
    }
    
    override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
        for touch in touches as! Set<UITouch> {
            let key = NSValue(nonretainedObject: touch)
            currentLines.removeValueForKey(key)
        }
    }
}
