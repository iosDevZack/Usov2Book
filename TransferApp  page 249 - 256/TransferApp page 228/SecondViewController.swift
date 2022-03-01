//
//  SecondViewController.swift
//  TransferApp page 228
//
//  Created by Женя  on 25.02.22.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var dataTextField: UITextField!
    
    var updatingData: String = ""
    
    //Замыкание
    var completionHandler: ((String) -> Void)?
    
    var handleUpdatedDataDelegate: DataUpdateProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTextFieldData(withText: updatingData)
        
    }
    
    private func updateTextFieldData(withText text: String) {
        dataTextField.text = text
    }
    
    @IBAction func saveDataWithProperty(_ sender: Any) {
        self.navigationController?.viewControllers.forEach({ viewController in
            (viewController as? ViewController)?.updatedData = dataTextField.text ?? ""
        })
    }
    
    
    // Переход от Б к А
    // Передача данных с помощью делегата
    @IBAction func saveDataWithDelegate (_ sender: UIButton) {
        // получаем обновленные данные
        let updatedData = dataTextField.text ?? ""
        
        // вызываем метод делегата
        handleUpdatedDataDelegate?.onDataUpdate(data: updatedData)
        
        // возвращаемся на предыдущий экран
        navigationController?.popViewController(animated: true)
    }
    
    
    // Переход от Б к А
    // Передача данных с помощью замыкания
    @IBAction func saveDataWithClosure(_ sender: UIButton) {
        
        // получаем обновленные данные
        let updatedData = dataTextField.text ?? ""
        
        // вызваем замыкание
        completionHandler?(updatedData)
        
        //возвращаемся на предыдущий экран
        navigationController?.popViewController(animated: true)
    }
}
