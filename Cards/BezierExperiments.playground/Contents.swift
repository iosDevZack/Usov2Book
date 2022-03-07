//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        self.view = view
        
        // создаем кривые на сцене
        createBezier(on: view)
    }
    
    private func createBezier(on view: UIView) {
        // 1
        // создаем графический контекст (слой)
        // на нем в дальнейшем будут рисоваться кривые
        let shapeLayer = CAShapeLayer()
        
        // 2
        // добавляем слой в качестве дочернего к корневому слою корневого представления
        view.layer.addSublayer(shapeLayer)
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
