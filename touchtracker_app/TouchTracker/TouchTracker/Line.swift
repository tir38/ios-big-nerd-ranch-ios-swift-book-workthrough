
import Foundation
import CoreGraphics

struct Line: Equatable {
    var begin: CGPoint = CGPointZero
    var end: CGPoint = CGPointZero   
}

func == (lhs: Line, rhs: Line) -> Bool {
    return lhs.begin == rhs.begin && lhs.end == rhs.end
}