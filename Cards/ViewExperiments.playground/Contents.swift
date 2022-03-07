//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import CoreGraphics

class MyViewController : UIViewController {
    override func loadView() {
        setupViews()
    }
    // настройка представлений сцены
    private func setupViews() {
        self.view = getRootView()
        let redView = getRedView()
        let greenView = getGreenView()
        let whiteView = getWhiteView()
        let pinkView = getPinkView()
        
        // выровняем зелное представление по центру красного
        set(view: greenView, toCenterOfView: redView)
        
        // поворот красного представления
        redView.transform = CGAffineTransform(rotationAngle: .pi/3)
        
//        // выровняем белое представление по центру красного
//        set(view: whiteView, toCenterOfView: redView)
        
        // позиционируем белое представление с помощью свойства center
        whiteView.center = greenView.center
        
        self.view.addSubview( redView )
        redView.addSubview( greenView )
        redView.addSubview( whiteView )
        self.view.addSubview( pinkView )
        
    }
    // создание корневого представления
    private func getRootView() -> UIView {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }
    
    // создание красного представления
    private func getRedView() -> UIView {
        let viewFrame = CGRect(x: 50, y: 50, width: 200, height: 200)
        let view = UIView(frame: viewFrame)
        view.backgroundColor = .red
        view.clipsToBounds = true
        return view
    }
    // создание представления зеленого цвета
    private func getGreenView() -> UIView {
        let view = UIView(frame: CGRect(x: 10, y: 10, width: 180, height: 180))
        view.backgroundColor = .green
        return view
    }
    
    // создание представления белого цвета
    private func getWhiteView() -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        view.backgroundColor = .white
        return view
    }
    
    private func getPinkView() -> UIView {
        let view = UIView(frame: CGRect(x: 50, y: 300, width: 100, height: 100))
        view.backgroundColor = .systemPink
        view.layer.borderWidth = 5
        view.layer.borderColor = UIColor.yellow.cgColor
        view.layer.cornerRadius = 10
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 20
        view.layer.shadowOffset = CGSize(width: 10, height: 20)
        view.layer.shadowColor = UIColor.white.cgColor
        view.layer.opacity = 0.7
        return view
    }
    
    // Расчет координат элемента по центру другого
    private func set(view moveView: UIView, toCenterOfView baseView: UIView) {
        // размеры вложенного представления
        let moveViewWidth = moveView.frame.width
        let moveViewHeight = moveView.frame.height
        
        // размеры родительского представления
        let baseViewWidth = baseView.bounds.width
        let baseViewHeight = baseView.bounds.height
        
        // вычисление и изменение координат
        let newXCoordinate = (baseViewWidth - moveViewWidth) / 2
        let newYCoordinate = (baseViewHeight - moveViewHeight) / 2
        
        moveView.frame.origin = CGPoint(x: newXCoordinate, y: newYCoordinate)
        
        moveView.center = CGPoint(x: baseView.bounds.midX, y: baseView.bounds.midY)
    }
    
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
