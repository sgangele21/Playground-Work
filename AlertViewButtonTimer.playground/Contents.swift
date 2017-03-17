import UIKit
// Allows capability to run views on iPad
import PlaygroundSupport

public class CircleProgressView {
    
    // View for CircleProgressView to be placed on
    private let mainView: UIView
    // Path the shapeLayer should follow
    private var bezierPath: UIBezierPath
    // The acutal layer that will be displayed on the mainView
    private var shapeLayer: CAShapeLayer
    
    private let normalColor: UIColor
    private let highlightedColor: UIColor
    private let fillColor: UIColor
    
    private var timer: Timer?
    //TODO: End Progress at total duration
    private let totalDuration: Double
    private var currentDuration: Double {
        didSet {
            // Update the total percentage the circle should display
            self.shapeLayer.strokeEnd = CGFloat(currentDuration) / CGFloat(totalDuration)
        }
    }
    
    init(totalDuration: Double, mainView: UIView, normalColor: UIColor, highlightedColor: UIColor, fillColor: UIColor) {
        self.totalDuration = totalDuration
        self.currentDuration = 0.0
        self.mainView = mainView
        self.normalColor = normalColor
        self.highlightedColor = highlightedColor
        self.fillColor = fillColor
        
        // Initialization of bezier path
        let arcCenter = self.mainView.center
        let radius = (self.mainView.frame.width / 2) - 5 // 5 for padding
        // Angles are in radians
        let startAngle = -CGFloat.pi / 2
        let endAngle = 3*CGFloat.pi / 2
        self.bezierPath = UIBezierPath(arcCenter: arcCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        self.shapeLayer = CAShapeLayer()
        self.setupUI()
        self.setupNormalState()
    }
    
    private func setupNormalState() {
        self.shapeLayer.strokeColor = self.normalColor.cgColor
        self.currentDuration = self.totalDuration
    }
    
    private func setupUI() {
        // Make shapeLayer conform to bezierPath
        self.shapeLayer.path = self.bezierPath.cgPath
        self.shapeLayer.fillColor = self.fillColor.cgColor
        self.shapeLayer.strokeColor = self.normalColor.cgColor
        self.shapeLayer.lineCap = "round"
        
        // Make line width adaptive
        self.shapeLayer.lineWidth = 7.0
        self.shapeLayer.strokeEnd = 0.0
        self.shapeLayer.strokeStart = 0.0
        // Add circle on top of mainView's layers
        self.mainView.layer.insertSublayer(self.shapeLayer, at: 0)
    }
    
    public func startProgress() {
        self.currentDuration = 0.0
        self.shapeLayer.strokeColor = highlightedColor.cgColor
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            self.currentDuration += 0.1
        }
    }
    
    public func stopProgress() {
        self.shapeLayer.strokeColor = normalColor.cgColor
        // Invalidate stops the firing of the selector from the timer
        self.timer?.invalidate()
        self.timer = nil
        self.currentDuration = 0.0
        self.setupNormalState()
    }
}


public class ProgressViewCircleButton: UIButton {
    
    var circleProgressView: CircleProgressView?
    
    // Required - every subclass of this class must implement this initializer
    required public init(frame: CGRect, totalDuration: Double, normalColor: UIColor, highlightedColor: UIColor, fillColor: UIColor) {
        super.init(frame: frame)
        self.circleProgressView = CircleProgressView(totalDuration: totalDuration, mainView: self, normalColor: normalColor, highlightedColor: highlightedColor, fillColor: fillColor)
    }
    
    public init()  {
        super.init(frame: CGRect.zero)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Start progress when the button is touched
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.circleProgressView?.startProgress()
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.25, options: [.allowUserInteraction, .curveEaseInOut], animations: {() in
            self.transform  = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }, completion: nil)
    }
    
    // End progress when the button is no longer touched
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.25, options: [.allowUserInteraction, .curveEaseInOut], animations: {() in
            self.transform = CGAffineTransform.identity
        }, completion: nil)
        self.circleProgressView?.stopProgress()
    }
    
}

// TODO: Make the timer function as a property for the ProgressViewCircleButton class
public class ViewController: UIViewController {
    
    var alertButton: ProgressViewCircleButton = ProgressViewCircleButton()
    // Timer to see how long the button is pressed for
    var timer: Timer? = nil
    var timeCounter = 0.0
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.darkGray
        self.setupAlertButton()
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupAlertButton() {
        // Initialize alertButton with ProgressViewCircle
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        self.alertButton = ProgressViewCircleButton(frame: frame, totalDuration: 10.0, normalColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), highlightedColor: #colorLiteral(red: 0.745098054409027, green: 0.156862750649452, blue: 0.0745098069310188, alpha: 1.0), fillColor: UIColor.clear)
        // Add selectors for various types of touches
        self.alertButton.addTarget(self, action: #selector(alertButtonTouchUp), for: .touchUpInside)
        self.alertButton.addTarget(self, action: #selector(alertButtonTouchDown), for: .touchDown)
        // Add alertButton to view, and position it
        self.view.addSubview(self.alertButton)
        self.alertButton.translatesAutoresizingMaskIntoConstraints = false
        alertButton.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.bottomAnchor, constant: -10).isActive = true
        alertButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        alertButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        alertButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    // Called when you touch the button, then remove finger inside of button
    func alertButtonTouchUp() {
        let title = String(format: "%.2f Seconds", self.timeCounter)
        showAlert(viewController: self, title: title, message: "You held button down this long")
        self.resetTimer()
    }
    
    // Called as soon as you touch the button
    // Starts the timer
    func alertButtonTouchDown() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.10, repeats: true) { timer in
            self.timeCounter += 0.10
        }
    }
    
    // Stops and resets the timer
    func resetTimer() {
        self.timer!.invalidate()
        self.timer = nil
        self.timeCounter = 0
    }
    
    func showAlert(viewController: UIViewController, title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        alertController.addAction(alertAction)
        // Present alertController
        viewController.show(alertController, sender: nil)
    }
}

// Show view controller on iPad
let vc = ViewController()
PlaygroundPage.current.liveView = vc
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView


