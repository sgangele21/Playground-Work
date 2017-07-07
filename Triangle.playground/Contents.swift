import UIKit

public class Triangle: UIView {
    
    init(frame: CGRect, withCurve: Bool) {
        super.init(frame: frame)
        self.setupTriangle(frame: frame, addCurve: withCurve)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTriangle(frame: CGRect, addCurve: Bool) {
        let path = UIBezierPath()
        // Start creating the frame of the triangle, by starting at left bottom corner
        let leftEndPoint = CGPoint(x: 0, y: self.frame.height)
        let topPoint = CGPoint(x: self.frame.width / 2, y: 0)
        let rightEndPoint = CGPoint(x: self.frame.width, y: self.frame.height)
        let middlePoint = CGPoint(x: frame.width / 2, y: frame.height / 2)
        // Create the path for line to be drawn
        path.move(to: leftEndPoint)
        path.addLine(to: topPoint)
        path.addLine(to: rightEndPoint)
        addCurve ?
            path.addQuadCurve(to: leftEndPoint, controlPoint: middlePoint) :
            path.addLine(to: leftEndPoint)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        if let fillColor = self.backgroundColor {
            shapeLayer.fillColor = fillColor.cgColor
        }
        // This masks the view to the shape of the layer you set
        self.layer.mask = shapeLayer
    }
}

let frame = CGRect(x: 0, y: 0, width: 50, height: 50)
let curvedTriangle = Triangle(frame: frame, withCurve: true)
curvedTriangle.backgroundColor = UIColor.blue

curvedTriangle // Look at curved triangle here

let normalTriangle = Triangle(frame: frame, withCurve: false)
normalTriangle.backgroundColor = UIColor.green

normalTriangle // Look at the normal triangle here
