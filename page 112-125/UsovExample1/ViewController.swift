//
//  ViewController.swift
//  UsovExample1
//
//  Created by Женя  on 14.01.22.
// page 112-125

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var label: UILabel!
    
    // Сущность "Игра"
    var game: Game!
    
    
    // MARK: - Жизненный цикл
    
    override func loadView() {
        super.loadView()
        print("loadView")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        
        // Создаем генератор случайных чисел
        let generator = NumberGenerator(startValue: 1, endValue: 50)!
        
        // Создаем сущность игра
        game = Game(valueGenerator: generator, rounds: 5)
        
        // Обновляем данные о текущем значении загаданного числа
        updateLabelWithSecretNumber(newText: String(game.currentRound.currentSecretValue))
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
    
    // MARK: - Взаимодействие View - Model
    
    // Проверка выбранного пользователем числа
    @IBAction func checkNumber() {
        
        // Высчитываем очки за раунд
        game.currentRound.calculateScore(with: Int(slider.value))
        
        // Проверяем, окончена ли игра
        if game.isGameEnded {
            
            // Показываем окно с итогами
            showAlertWith(score: game.score)
            
            // Рестартуем игру
            game.restartGame()
        } else {
            // Начинаем новый раунд игры
            game.startNewRound()
        }
        // Обновляем данные о текущем значении загаданного числа
        updateLabelWithSecretNumber(newText: String(game.currentRound.currentSecretValue))
    }
    
    // MARK: - Обновление View
    
    // Обновление текста загаданного числа
    func updateLabelWithSecretNumber(newText: String ) {
        label.text = newText
    }
    
    // Отображение всплывающего окна со счетом
    private func showAlertWith( score: Int ) {
        let alert = UIAlertController(
            title: "Игра окончена",
            message: "Вы заработали \(score) очков",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Начать заново", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}



