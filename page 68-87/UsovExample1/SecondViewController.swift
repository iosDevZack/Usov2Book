//
//  SecondViewController.swift
//  UsovExample1
//
//  Created by Женя  on 1.02.22.
//

import UIKit

class SecondViewController: UIViewController {
    
    override func loadView() {
        super.loadView()
        print("loadView SecondViewController")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad SecondViewController")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear SecondViewController")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear SecondViewController")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear SecondViewController")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear SecondViewController")
    }
    
    @IBAction func hideCurrentScreen() {
        self.dismiss(animated: true, completion: nil)
    }
}
