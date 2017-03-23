import UIKit

class ViewController: UIViewController {
    
    let imageView = UIImageView()
    let imageStringURL = "https://thegeekintel.files.wordpress.com/2013/02/batman-the-dark-knight-3_00448943.jpg"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchAndAssignImage()
        self.setupImageView()
    }
    
    func fetchAndAssignImage() {
        let url = URL(string: imageStringURL)
        imageView.asyncImageDownload(url: url!)
    }
    
    func setupImageView() {
        self.view.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        self.imageView.layer.masksToBounds = true
        
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor).isActive = true
        self.imageView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        self.imageView.heightAnchor.constraint(lessThanOrEqualToConstant: self.view.frame.height).isActive = true
    }
    
}

// Extension that allows image to be loaded asynchronously using GCD
extension UIImageView {
    func asyncImageDownload(url: URL) {
        DispatchQueue.global(qos: .background).async {
            // Neat way of turning error handling into optional handling
            guard let data = try? Data(contentsOf: url) else { return }
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}

import PlaygroundSupport
PlaygroundPage.current.liveView = ViewController()
PlaygroundPage.current.needsIndefiniteExecution = true
