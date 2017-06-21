import UIKit
import PlaygroundSupport

// Disable caching to get rid of sandbox bug in Xcode
URLCache.shared = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)

public class ViewController: UIViewController {
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // Creation of a random thread given to us by apple, from a pool of threads
        let queue = DispatchQueue.global()
        
        // Asynchronous function
        queue.async {
            self.loadImageOfDog()
        }
        
        // Notice that this will be printed BEFORE the image is shown, this is because it is on a concurrent / asynchronous queue
        // This shows the true power, as you can still run tasks while other tasks are going on, the execution flow is no longer linear, it is concurrent
        print("Image is loading")
        
    }
    
    // Simple fetching of an image
    func loadImageOfDog() -> UIImage {
        let url = URL(string: "https://vetstreet.brightspotcdn.com/dims4/default/78480cb/2147483647/crop/0x0%2B0%2B0/resize/645x380/quality/90/?url=https%3A%2F%2Fvetstreet-brightspot.s3.amazonaws.com%2Fd5%2F10e8609e8c11e0a2380050568d634f%2Ffile%2FBernese-Mtn-2-645mk062111.jpg")
        
        let data = try! Data(contentsOf: url!)
        let image = UIImage(data: data)!
        print("Image has arrived!")
        return image
    }
}

// Disclaimer: This has to be done inside a view controller for threading to work accuratley
let vc = ViewController()
vc.view.backgroundColor = UIColor.lightGray
PlaygroundPage.current.liveView = vc
PlaygroundPage.current.needsIndefiniteExecution = true






