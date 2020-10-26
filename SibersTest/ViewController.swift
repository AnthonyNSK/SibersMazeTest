//
//  ViewController.swift
//  SibersTest
//
//  Created by Kuzhelev Anton on 11.10.2020.
//  Copyright © 2020 Kuzhelev Anton. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var numberTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberTextField.keyboardType = .numberPad
        
    }

    @IBAction func okButton(_ sender: UIButton) {
       
        let number = Int(numberTextField.text!) ?? 0
        if number < 1 {
            showError()
            return
        }
        MazeGenerator.shared.generationOfTheMaze(numberOfRooms: number)
        performSegue(withIdentifier: "Play", sender: self)
    }
    
    func showError() {
        let alert = UIAlertController(title: "Некорректное количество комнат лабиринта", message: nil, preferredStyle: .alert)
        let actionAlert = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(actionAlert)
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
    }
    
}
