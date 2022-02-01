//
//  ViewController.swift
//  UsovExample1
//
//  Created by Женя  on 14.01.22.
// page 87-92

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var label: UILabel!
    
    
    // загаданное число
    var number: Int = 0
    
    // раунд
    var round: Int = 1
    
    // сумма очков за раунд
    var points: Int = 0
    
    // ленивое свойство для хранения View Controller
    lazy var secondViewController: SecondViewController = getSecondViewController()
    
    
    override func loadView() {
        super.loadView()
        print("loadView")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        // генерируем случайное число
        self.number = Int.random(in: 1...50)
        // передаем значение случайного числа в label
        self.label.text = String(self.number)
        //устанавливаем счетчик раундов на 1
        self.round = 1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear")
    }
    
    @IBAction func checkNumber() {
        // получаем значение на слайдере
        let numSlider = Int(self.slider.value.rounded())
        // сравниваем значение с загаданным числом
        // и подсчитываем очки
        if numSlider > self.number {
            self.points += 50 - numSlider + self.number
        } else if numSlider < self.number {
            self.points += 50 - self.number + numSlider
        } else {
            self.points += 50
        }
        if self.round == 5 {
            // выводим информационное окно
            // с результатами игры
            let alert = UIAlertController(
                title: "Игра окончена",
                message: "Вы заработали \(self.points) очков",
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Начать заново", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            self.round = 1
            self.points = 0
        } else {
            self.round += 1
        }
        // генерируем случайное число
        self.number = Int.random(in: 1...50)
        // передаем значение случайного числа в label
        self.label.text = String(self.number)
    }
    
    // приватный метод, загружающий View Controller
    private func getSecondViewController() -> SecondViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SecondViewController")
        return viewController as! SecondViewController
    }
    
//    @IBAction func showNextScreen() {
//        self.present(secondViewController, animated: true, completion: nil)
        
//        // загрузка Storyboard
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        // загрузка View Controller и его сцены со Storyboard
//        let viewController = storyboard.instantiateViewController(withIdentifier: "SecondViewController")
//        // отображение сцены на экране
//        self.present(viewController, animated: true, completion: nil)
//    }
}



