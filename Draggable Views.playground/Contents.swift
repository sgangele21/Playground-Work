import UIKit


private protocol Draggable {
    // Can't put access modifiers in protocols
    func configDragging(allowDragging: Bool)
    
    func setupDragging()
    func removeDragging()
    func panning(gesture: UIPanGestureRecognizer)
    
}

private protocol Bouncable {
    func configBouncing(allowBouncing: Bool)
    
    func setupBouncing()
    func removeBouncing()
    func tapping(gesture: UITapGestureRecognizer)
}



// Allows views to be draggable
extension UIView: Draggable, UIGestureRecognizerDelegate {
    
    public func configDragging(allowDragging: Bool) {
        allowDragging ? self.setupDragging()
            : self.removeDragging()
    }
    
    fileprivate func setupDragging() {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(self.panning))
        gesture.delegate = self
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(gesture)
    }
    
    fileprivate func removeDragging() {
        self.gestureRecognizers?.removeAll()
        self.isUserInteractionEnabled = false
    }
    
    @objc fileprivate func panning(gesture: UIPanGestureRecognizer) {
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
    
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}


// Allows views to be bouncy upon a press
extension UIView: Bouncable {
    
    public func configBouncing(allowBouncing: Bool) {
        allowBouncing ? self.setupBouncing()
            : self.removeBouncing()
    }
    
    fileprivate func setupBouncing() {
        let control = UIControl(frame: self.frame)
        control.addTarget(self, action: #selector(tapping), for: .touchDown)
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(tapping))
        gesture.delegate = self
        self.isUserInteractionEnabled = true
        gesture.minimumPressDuration = 0
        self.addGestureRecognizer(gesture)
    }
    
    fileprivate func removeBouncing() {
        self.gestureRecognizers?.removeAll()
        self.isUserInteractionEnabled = false
    }
    
    @objc fileprivate func tapping(gesture: UITapGestureRecognizer) {
        print("Tapping")
        switch gesture.state {
        case .began:
            self.configBounce(enlarge: true)
            break
        case .ended:
            self.configBounce(enlarge: false)
            break
        default:
            break
        }
    }
    
    private func configBounce(enlarge: Bool) {
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.25, options: [.allowUserInteraction, .curveEaseInOut], animations: {() in
            self.transform  = enlarge ? CGAffineTransform(scaleX: 1.1, y: 1.1) : CGAffineTransform.identity
        }, completion: nil)
    }
}


public class Circle: UIView {
    
    required public init(radius: CGFloat) {
        super.init(frame: CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2))
        self.layer.cornerRadius = self.frame.width / 2
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class ViewController: UIViewController {
    
    let circle = Circle(radius: 50)
    let blueColor = UIColor(colorLiteralRed: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0)
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.circle.configDragging(allowDragging: true)
        self.circle.configBouncing(allowBouncing: true)
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.circle)
        self.circle.backgroundColor = self.blueColor
    }
}


import PlaygroundSupport

PlaygroundPage.current.liveView = ViewController()
PlaygroundPage.current.needsIndefiniteExecution = true
