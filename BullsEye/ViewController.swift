//
//  ViewController.swift
//  BullsEye
//
//  Created by Juanma Gutiérrez on 21/2/24.
//

import UIKit

struct Modal {
    var title: String
    var message: String
    var action: String
    
    init() {
        self.title = ""
        self.message = ""
        self.action = ""
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    let initialPoints: Int = 100
    var targetValue: Int = 0
    var currentValue: Int = 0
    var scoreValue: Int = 0
    var roundValue: Int = 1
    var newGame: Bool = false
    var modal: Modal = Modal()

    override func viewDidLoad() {
        super.viewDidLoad()
        scoreValue = initialPoints
        startNewRound()
    }
    
    func startNewRound(){
        targetValue = Int(arc4random_uniform(100)) + 1
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabels()
    }
    
    @IBAction func startNewGame(){
        resetGame()
        startNewRound()
    }
    
    @IBAction func hitMeIsClicked() {
        calculatePoints()
        showContinueOrWin()
        updateLabels()
    }
    
    @IBAction func showInfoIsClicked(){
        modal.title = "How to play"
        modal.message = "You should try to get as close as possible to the indicated target.\n\nYou start with 100 points and lose points each round you miss.\n\nGood luck!"
        modal.action = "Close"
        showModal()
    }
    
    func showContinueOrWin(){
        if (targetValue - currentValue) == 0 {
            modal.title = "PERFECT!!"
            modal.message = "You have made a Bull's Eye with \(scoreValue) points and \(roundValue) rounds!!"
            modal.action = "New game"
            resetGame()
        }
        else{
            modal.title = "Try again"
            modal.message = "The value of the slider is: \(currentValue)" + "\nThe target value is \(targetValue)"
            modal.action = "Continue"
        }
        showModal()
    }
       
    func showModal(){
        let alert = UIAlertController(title: modal.title, message: modal.message, preferredStyle: .alert)
        let action = UIAlertAction(title: modal.action, style: .default, handler: {
            action in
                self.startNewRound()
        })
        alert.addAction(action)
        present (alert, animated: true, completion: nil)
    }
    
    func resetGame(){
        scoreValue = initialPoints
        roundValue = 1
        scoreLabel.text = String(initialPoints)
        roundLabel.text = String(1)
    }
    
    func calculatePoints(){
        scoreValue -= calculatePointsDiference()
        roundValue += 1
    }

    func updateLabels(){
        scoreLabel.text = String(scoreValue)
        roundLabel.text = String(roundValue)
        targetLabel.text = String(targetValue)
    }
    
    func calculatePointsDiference() -> Int {
        print (targetValue, currentValue, abs(targetValue - currentValue))
        return abs(targetValue - currentValue)
    }

    @IBAction func sliderMoved(_ slider: UISlider){
        currentValue = lroundf(slider.value)
    }
}
