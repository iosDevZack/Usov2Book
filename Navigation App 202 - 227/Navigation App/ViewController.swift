//
//  ViewController.swift
//  Navigation App
//
//  Created by Женя  on 24.02.22.
//

import UIKit

class ViewController: UIViewController {
    
    // Ссылка на сториборд, где размещен данный ViewController
    let storyboardInstance = UIStoryboard(name: "Main", bundle: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func toGreenScene(_ sender: Any) {
        // получаем ссылку на следующий контроллер
        // в данном случае следующий - это зеленый
        let nextViewController =
        storyboardInstance.instantiateViewController(withIdentifier: "greenViewController")
        // обращаемся к Navigation Controller
        // и вызываем метод перехода к новому контроллеру
        self.navigationController?.pushViewController(nextViewController,animated: true)
    }
    
    @IBAction func toYellowScene(_ sender: Any) {
        let nextViewController = storyboardInstance.instantiateViewController(withIdentifier: "yellowViewController")
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @IBAction func toRootScene(_ sender: Any) {
        // обращаемся к Navigation Controller
        // и вызываем метод перехода к корневому контроллеру
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    

}

