import UIKit

let blueColor = UIColor(colorLiteralRed: 0.0, green: 122.0 / 255.0, blue: 1.0, alpha: 1.0)

public class ViewController: UIViewController {
    
    var progressView = UIProgressView()
    var panningGesture = UIPanGestureRecognizer()
    
    var progressValues: [String : Float] = [:]
    let startKey = "Start"
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.setupProgressBar()
        self.setupGesture()
        self.view.backgroundColor = UIColor.white
    }
    
    func setupProgressBar() {
        self.progressView = UIProgressView(progressViewStyle: .bar)
        self.progressView.progressTintColor = blueColor
        self.progressView.trackTintColor = UIColor.lightGray
        
        self.view.addSubview(self.progressView)
        self.progressView.translatesAutoresizingMaskIntoConstraints = false
        
        // Anchoring
        self.progressView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.progressView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.progressView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.progressView.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
    
    private func setupGesture() {
        self.panningGesture = UIPanGestureRecognizer(target: self, action: #selector(panning))
        self.view.addGestureRecognizer(self.panningGesture)
    }
    
    @objc func panning(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            self.progressValues[startKey] = self.progressView.progress
            break
        default:
            break 
        }
        let screenWidth = UIScreen.main.bounds.width
        let translation = sender.translation(in: self.view)
        // The 1.5 is just a little speed boost for your panning value
        let percentage = (translation.x / screenWidth) * 1.1
        self.progressView.progress = Float(percentage) + self.progressValues[startKey]!
    }
}


import PlaygroundSupport
let vc = ViewController()
PlaygroundPage.current.liveView = vc
PlaygroundPage.current.needsIndefiniteExecution = true
