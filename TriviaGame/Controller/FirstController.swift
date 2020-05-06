//
//  FirstController.swift
//  TriviaGame
//
//  Created by Toni De Gea on 04/05/2020.
//  Copyright © 2020 Toni De Gea. All rights reserved.
//

import UIKit

class FirstController: UIViewController {
    
    
    @IBOutlet weak var player1: UITextField!
    
    @IBOutlet weak var player2: UITextField!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        hideKeyboardWhenTappedAround()
    }
    
    
    @IBAction func nextBttn(_ sender: UIButton) {
        
        if let player = player1.text {
            if player.isEmpty || player == " " {
                let alert = UIAlertController(title: "", message: "Add Player 1", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                }))
                self.present(alert, animated: true, completion: nil)
            } else {
                defaults.set(player1.text, forKey: "Player1")
            }
        }
        
        if let player = player2.text {
            if player.isEmpty || player == " " {
                let alert = UIAlertController(title: "", message: "Add Player 2", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                }))
                self.present(alert, animated: true, completion: nil)
            } else {
                defaults.set(player2.text, forKey: "Player2")
            }
        }
    }
}


