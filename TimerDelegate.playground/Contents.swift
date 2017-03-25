import UIKit

// The delegate
// Needs to conform to type of class, no types like structs, or enums
protocol TimerDelegate: class {
    func TimerWentOff()
}
// Class that has delegate as property, and calls any class that implemens TimerDelegate protocol
public class SimpleTimer {
    
    private var timer: Timer?
    // Prevents retain cycle
    weak var delegate: TimerDelegate?
    private var finalTime: Int
    private var currentTime: Int
    
    init(time: Int) {
        self.finalTime = time
        self.currentTime = 0
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(trackTimer), userInfo: nil, repeats: true)
        
    }
    
    @objc func trackTimer(timer: Timer) {
        self.currentTime += 1
        if self.currentTime == self.finalTime {
            self.timer?.invalidate()
            self.delegate?.TimerWentOff()
        }
    }
}

// Class that implements the delegate
public class ViewController: UIViewController, TimerDelegate {
    
    weak var simpleTimer: SimpleTimer?
    // The amount of that it takes for SimpleTimer to go off
    let time = 5
    var label = UILabel()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.simpleTimer = SimpleTimer(time: self.time)
        self.simpleTimer?.delegate = self
        self.setupLabel()
    }
    
    func setupLabel() {
        self.label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        self.label.numberOfLines = 0
        self.label.text = "Wait for timer of \(self.time) seconds"
        self.view.addSubview(self.label)
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    func TimerWentOff() {
        self.label.text = "Timer went off!"
    }
    
}


import PlaygroundSupport

PlaygroundPage.current.liveView = ViewController()
PlaygroundPage.current.needsIndefiniteExecution = true
