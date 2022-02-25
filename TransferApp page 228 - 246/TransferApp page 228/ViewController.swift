//
//  ViewController.swift
//  TransferApp page 228
//
//  Created by Женя  on 25.02.22.
// Page 228 - 246

import UIKit



class ViewController: UIViewController {
    
    @IBOutlet weak var dataLabel: UILabel!
    
    var updateData: String = "Test"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLabel(withText: updateData)
    }
    
    private func updateLabel(withText text: String) {
        dataLabel.text = updateData
    }
    
    @IBAction func editDataWithProperty(_ sender: Any) {
        // получаем вью контроллер, в который происходит переход
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editScreen = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        
        // Передаем данные
        editScreen.updatingData = dataLabel.text ?? ""
        
        // переходим к следующему экрану
        self.navigationController?.pushViewController(editScreen, animated: true)
    }


}

