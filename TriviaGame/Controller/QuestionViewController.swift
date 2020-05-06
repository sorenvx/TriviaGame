//
//  QuestionViewController.swift
//  TriviaGame
//
//  Created by Toni De Gea on 04/05/2020.
//  Copyright © 2020 Toni De Gea. All rights reserved.
//

import UIKit
import CoreData

class QuestionViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var namePlayer1: UILabel!
    @IBOutlet weak var scorePlayer1: UILabel!
    @IBOutlet weak var namePlayer2: UILabel!
    @IBOutlet weak var scorePlayer2: UILabel!
    @IBOutlet weak var currentlyPlaying: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var bttn1: UIButton!
    @IBOutlet weak var bttn2: UIButton!
    @IBOutlet weak var bttn3: UIButton!
    @IBOutlet weak var bttn4: UIButton!
    @IBOutlet weak var numberQuestion: UILabel!
    
    //MARK: - General variables
    
    let manager = DataManager()
    let defaults = UserDefaults.standard
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var questionNumber = 0
    var scorePlayerOne = 0
    var scorePlayerTwo = 0
    var selectedAnswer = ""
    var allAnwsers: [String] = []
    
    var results: [Result] = [] {
        didSet {
            DispatchQueue.main.async {
                self.questionLabel.text = self.results[self.questionNumber].question
                self.allAnwsers = self.results[self.questionNumber].incorrectAnswers
                self.allAnwsers.append(self.results[self.questionNumber].correctAnswer)
                self.allAnwsers.shuffle()
                
                self.bttn1.setTitle(self.allAnwsers[0], for: .normal)
                self.bttn2.setTitle(self.allAnwsers[1], for: .normal)
                self.bttn3.setTitle(self.allAnwsers[2], for: .normal)
                self.bttn4.setTitle(self.allAnwsers[3], for: .normal)
                self.selectedAnswer = self.results[self.questionNumber].correctAnswer
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        namePlayer1.text = defaults.string(forKey: "Player1")
        namePlayer2.text = defaults.string(forKey: "Player2")
        currentlyPlaying.text = namePlayer1.text
        updateUI()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        questions()
    }
    
    //MARK: - Fetch data
    
    func questions() {
        manager.getQuestions { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let data):
                self?.results = data
            }
        }
    }
    
    //MARK: - Display data and UI
    
    func updateQuestions() {
        if questionNumber <= results.count - 1 {
            questionLabel.text = results[questionNumber].question
            allAnwsers = results[questionNumber].incorrectAnswers
            allAnwsers.append(results[questionNumber].correctAnswer)
            allAnwsers.shuffle()
            print(allAnwsers)
            
            bttn1.setTitle(allAnwsers[0], for: .normal)
            bttn2.setTitle(allAnwsers[1], for: .normal)
            bttn3.setTitle(allAnwsers[2], for: .normal)
            bttn4.setTitle(allAnwsers[3], for: .normal)
            selectedAnswer = results[questionNumber].correctAnswer
            
        } else if questionNumber > 19 {
            
            let alert = UIAlertController(title: winner(), message: "This is the end. Would you like to restart?", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Restart", style: .default) { action in
                
                let infoGeneral = InfoGeneral(context: self.context)
                infoGeneral.currentDate = Date()
                infoGeneral.firstPlayer = self.namePlayer1.text
                infoGeneral.secondPlayer = self.namePlayer2.text
                infoGeneral.firstPlayerScore = Int64(self.scorePlayerOne)
                infoGeneral.secondPlayerScore = Int64(self.scorePlayerTwo)
                
                self.saveInfo()
                
                self.restartTrivia()
            }
            
            alert.addAction(restartAction)
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    func updateUI() {
        scorePlayer1.text = "Score: \(scorePlayerOne)"
        scorePlayer2.text = "Score: \(scorePlayerTwo)"
        numberQuestion.text = "\(questionNumber)"
        updateQuestions()
    }
    
    func restartTrivia() {
        questionNumber = 0
        scorePlayerOne = 0
        scorePlayerTwo = 0
        updateQuestions()
        updateUI()
    }
    
    func playerPlaying() { // to alternate between the names so they know who's playing
        if currentlyPlaying.text == namePlayer1.text {
            currentlyPlaying.text = namePlayer2.text
        } else if currentlyPlaying.text == namePlayer2.text  {
            currentlyPlaying.text = namePlayer1.text
        }
    }
    
    func addScore() {
        if currentlyPlaying.text == namePlayer1.text {
            scorePlayerOne += 1
        } else if currentlyPlaying.text == namePlayer2.text {
            scorePlayerTwo += 1
        }
    }
    
    func winner() -> String { // this funcion tells the winner based on the score
        
        var wins = ""
        
        if scorePlayerOne > scorePlayerTwo {
            wins = "\(namePlayer1.text!) is the winner!"
        } else if scorePlayerTwo > scorePlayerOne {
            wins = "\(namePlayer2.text!) is the winner!"
        }
        return wins
    }
    
    
    //MARK: - Core Data
    
    func saveInfo() {
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    
    //MARK: - Button Actions
    
    @IBAction func bttnPressed(_ sender: UIButton) {
        if sender.titleLabel?.text == selectedAnswer {
            addScore()
            
            let alert = UIAlertController(title: "CORRECT ANSWER", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Next", comment: ""), style: .default, handler: { _ in
                self.playerPlaying()
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            if questionNumber > 18 {
                
            } else {
                let alert = UIAlertController(title: "WRONG ANSWER", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("Next", comment: ""), style: .default, handler: { _ in
                    self.playerPlaying()
                }))
                self.present(alert, animated: true, completion: nil)
            }
            
        }
        
        questionNumber += 1
        updateUI()
    }
    
    
}


