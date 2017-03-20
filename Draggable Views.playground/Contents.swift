import UIKit


// Allows views to be draggable
extension UIView {
    
    public func configDragging(allowDragging: Bool) {
        allowDragging ? self.setupDragging()
            : self.removeDragging()
    }
    
    private func setupDragging() {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(self.panning))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(gesture)
    }
    
    private func removeDragging() {
        self.gestureRecognizers?.removeAll()
        self.isUserInteractionEnabled = false
    }
    
    @objc private func panning(gesture: UIPanGestureRecognizer) {
        print("Gesture recognized!")
        switch gesture.state {
        case .began:
            // Every time the button is pressed, grab the current frame position of the view, and update it based on that
            gesture.setTranslation(self.frame.origin, in: self)
            break
        default:
            break
        }
        // TODO: Figure out why self and self.superView are both working
        let translation = gesture.translation(in: self)
        // This does the acutal panning of the view
        // TODO: Figure out why center can't be used
        self.frame.origin.x = translation.x
        self.frame.origin.y = translation.y
    }
}

public class Circle: UIView  {
    
    required public init(radius: CGFloat) {
        super.init(frame: CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2))
        self.layer.cornerRadius = self.frame.width / 2
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // TODO: Create a simple protocol that adds bounce effects when touched
    
}

public class ViewController: UIViewController {
    
    let circle = Circle(radius: 50)
    let blueColor = UIColor(colorLiteralRed: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0)
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.circle.configDragging(allowDragging: true)
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.circle)
        self.circle.backgroundColor = self.blueColor
    }
}

import PlaygroundSupport

PlaygroundPage.current.liveView = ViewController()
PlaygroundPage.current.needsIndefiniteExecution = true
