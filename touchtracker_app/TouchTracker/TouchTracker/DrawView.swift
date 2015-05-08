
import UIKit

@IBDesignable
class DrawView: UIView {

    private var currentLines = [NSValue:Line]()
    private var finishedLines = [Line]()
    private var selectedLine: Line?
    
    private var moveRecognizer: UIPanGestureRecognizer!
    
    // MARK: init methods
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupGestures()
    }
    
    // MARK: private methods
    private func setupGestures() {
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: "doubleTap:")
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.delaysTouchesBegan = true // don't send touchesBegan events to touched view
        addGestureRecognizer(doubleTapRecognizer)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: "singleTap:")
        tapRecognizer.delaysTouchesBegan = true
        tapRecognizer.requireGestureRecognizerToFail(doubleTapRecognizer) // cause this recognizer to fail if doubleTap Recognizer succeeded
        addGestureRecognizer(tapRecognizer)
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: "longPress:")
        addGestureRecognizer(longPressRecognizer)
        
        moveRecognizer = UIPanGestureRecognizer(target: self, action: "moveLine:")
        moveRecognizer.delegate = self
        moveRecognizer.cancelsTouchesInView = false
        addGestureRecognizer(moveRecognizer)
    }
    
    private func strokeLine(line: Line) {
        let path = UIBezierPath()
        path.lineWidth = 10
        path.lineCapStyle = kCGLineCapRound
        
        path.moveToPoint(line.begin)
        path.addLineToPoint(line.end)
        path.stroke()
    }
    
    private func lineAtPoint(point: CGPoint) -> Line? {
        // Find a line close to point
        for line in finishedLines {
            let begin = line.begin
            let end = line.end
            // Check a few points on the line
            for var t: CGFloat = 0; t < 1.0; t += 0.05 {
            
                let x = begin.x + ((end.x - begin.x) * t)
                let y = begin.y + ((end.y - begin.y) * t)
            
                // If the tapped point is within 20 points, let's return this line
                if hypot(x - point.x, y - point.y) < 20.0 {
                    return line
                }
            }
        }
        
        // If nothing is close enough to the tapped point, then we did not select a line
        return nil
    }
    
    // MARK: public methods
    func doubleTap (gestureRecognizer: UIGestureRecognizer) {
        println("recognized as a double tap")
        
        currentLines.removeAll(keepCapacity: false)
        finishedLines.removeAll(keepCapacity: false)
        selectedLine = nil
        setNeedsDisplay()
    }
    
    func singleTap (gestureRecognizer: UIGestureRecognizer) {
        println("recognized as a single tap")
        
       let point = gestureRecognizer.locationInView(self)
        selectedLine = lineAtPoint(point)
        setNeedsDisplay()
        
        // setup menu controller
        let menu = UIMenuController.sharedMenuController()
        if let line = selectedLine {
            
            // make ourselves the target of menu item aciton messages
            becomeFirstResponder()
            
            // create delete menu item
            let deleteItem = UIMenuItem(title: "Delete", action: "deleteLine:")
            menu.menuItems = [deleteItem]
            
            menu.setTargetRect(CGRect(x: point.x, y: point.y, width: 2, height: 2), inView: self)
            menu.setMenuVisible(true, animated: true)
        } else {
            menu.setMenuVisible(false, animated: true)
        }
    }
    
    func longPress(gestureRecognizer: UIGestureRecognizer) {
        if gestureRecognizer.state == .Began {
            let point = gestureRecognizer.locationInView(self)
            selectedLine = lineAtPoint(point)
            
            if selectedLine != nil {
                currentLines.removeAll(keepCapacity: false)
            }
        } else if gestureRecognizer.state == .Ended {
                selectedLine = nil
        }
        setNeedsDisplay()
    }
    
    func moveLine(gestureRecognizer: UIPanGestureRecognizer) {
        if var line = selectedLine {
            // when the pan recognizer changes its position
            if gestureRecognizer.state == .Changed {
                // how far has the pan moved?
                let translation = gestureRecognizer.translationInView(self)
                
                // Add the translation to the current beginning and end points of the line
                // Make sure there are no copy and paste typos!
                line.begin.x += translation.x
                line.begin.y += translation.y
                line.end.x += translation.x
                line.end.y += translation.y
                // Redraw the screen
                setNeedsDisplay()
            }
        } else {
            // If we have not selected a line, we do not do anything here
            return
        }
    }
    
    func deleteLine(sender: AnyObject) {
        if let line = selectedLine {
            if let index = find(finishedLines, line) {
                finishedLines.removeAtIndex(index)
                selectedLine = nil
                setNeedsDisplay()
            }
        }
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
        
        // draw selected line
        if let line = selectedLine {
            UIColor.greenColor().setStroke()
            strokeLine(line)
        }
    
    }
    
    override func prepareForInterfaceBuilder() {
        backgroundColor = UIColor.blueColor()
        finishedLines = [Line(begin: CGPoint(x: 15, y: 40), end: CGPoint(x: 15, y: 630)),
            Line(begin: CGPoint(x: 350, y: 40), end: CGPoint(x: 350, y: 630))]
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
}

extension DrawView: UIGestureRecognizerDelegate {
    // MARK: implement UIGestureRecognizerDelegate protocol
        
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer,
            shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {

        // if doing move recognition then also handle other gesture recognition
        if moveRecognizer == gestureRecognizer {
            return true
        }
        return false
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
