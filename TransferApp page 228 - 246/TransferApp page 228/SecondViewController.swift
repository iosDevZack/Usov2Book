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
            (viewController as? ViewController)?.updateData = dataTextField.text ?? ""
        })
    }
}
