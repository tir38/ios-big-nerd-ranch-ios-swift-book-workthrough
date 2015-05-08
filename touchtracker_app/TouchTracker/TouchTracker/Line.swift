
import Foundation
import CoreGraphics

class Line: Equatable {
    var begin: CGPoint = CGPointZero
    var end: CGPoint = CGPointZero
    
    init(begin: CGPoint, end: CGPoint) {
        self.begin = begin
        self.end = end
    }
}

func == (lhs: Line, rhs: Line) -> Bool {
    return lhs.begin == rhs.begin && lhs.end == rhs.end
}