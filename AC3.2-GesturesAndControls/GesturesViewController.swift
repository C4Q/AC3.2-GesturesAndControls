//
//  GesturesViewController.swift
//  AC3.2-GesturesAndControls
//
//  Created by Jason Gresh on 9/29/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class GesturesViewController: UIViewController {
    var correctColorValue = UIColor.green
    var wrongColorValue = UIColor.red
    var resetScore = true
    var gameTime = 15
    var timer = Timer()
    var isBeingPlayed = false
    var winScore = 5
    var playerScore = 0
    
    
    
    
    
    enum ActionGesture: Int {
        case tap, doubleTap, twoFingerTap, leftSwipe, rightSwipe
    }
    
    var currentActionGesture = ActionGesture.tap {
        willSet {
            self.updateLabel(for: newValue)
        }
    }
    
    var currentScore: Int = 0 {
        willSet {
            self.scoreLabel.text = "Score: \(newValue)"
            playerScore = newValue
            
        }
    }
    
  
    
    @IBOutlet weak var actionToPerformLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet var rightSwipeGestureRecognizer: UISwipeGestureRecognizer!
    @IBOutlet var leftSwipeGestureRecognizer: UISwipeGestureRecognizer!
    @IBOutlet var tapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet var doubleTapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet var twoFingerTapGestureRecognizer: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapGestureRecognizer.require(toFail: doubleTapGestureRecognizer)
        self.currentActionGesture = self.pickRandomActionGesture()
        self.timerLabel.text = "\u{23F0}:" + String(gameTime)
        //self.actionToPerformLabel.text = "TOUCH TO PLAY"
       // enableControls(state: false)
        
        
    }
    
    // MARK: - Utility
    // update our label for each gesture
    func updateLabel(for actionGes: ActionGesture) {
        var updateText: String = ""
        switch actionGes {
        case .tap: updateText = "tap"
        case .doubleTap: updateText = "double tap"
        case .twoFingerTap: updateText = "two finger tap"
        case .leftSwipe: updateText = "swipe left"
        case .rightSwipe: updateText = "swipe right"
        }
        
        self.actionToPerformLabel.text = updateText
    }
    
    // a way to randomly get a gesture
    func pickRandomActionGesture() -> ActionGesture {
        let randomInt = Int(arc4random_uniform(5)) // number between 0-4
        return ActionGesture(rawValue: randomInt) ?? .tap
    }
    
    // MARK: - Actions
    @IBAction func didPerformGesture(_ sender: UIGestureRecognizer) {
        if isBeingPlayed == false{
            startGame()
            playGame(sender: sender)
            isBeingPlayed = true
        }else{
            playGame(sender: sender)
        }
        
    }
    
    //MARK: - Methods
    
    func isCorrect(_ correct: Bool) {
        self.currentActionGesture = pickRandomActionGesture()
        
        if correct {
            // use the "correctColorValue" to manipulate the red component of a color
            self.view.backgroundColor = self.correctColorValue
            // alternatively we can change the hue using this initializer of UIColor
            // self.view.backgroundColor = UIColor(hue: CGFloat(Float(self.correctColorValue)), saturation: 1.0, brightness: 1.0, alpha: 1.0)
            
            self.currentScore += 1
        }
        else {
            //resets score is switch is ON
            if resetScore{
                self.currentScore = 0
            }
            self.view.backgroundColor = wrongColorValue
        }
    }
    
    func playGame(sender:Any){
        
        if let tapGesture: UITapGestureRecognizer = sender as? UITapGestureRecognizer {
            switch (tapGesture.numberOfTapsRequired, tapGesture.numberOfTouchesRequired) {
                
            case (1, 1):
                print("Heck yea I was tapped")
                self.isCorrect(self.currentActionGesture == .tap)
                
            case (2, 1):
                print("double tap!")
                self.isCorrect(self.currentActionGesture == .doubleTap)
                
            case (1, 2):
                print("two finger tap!")
                self.isCorrect(self.currentActionGesture == .twoFingerTap)
                
            default:
                print("tap type was wrong!")
                self.isCorrect(false)
            }
        }
        
        if let swipeGesture: UISwipeGestureRecognizer = sender as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
                
            case UISwipeGestureRecognizerDirection.left:
                print("did swipe left")
                self.isCorrect(self.currentActionGesture == .leftSwipe)
                
            case UISwipeGestureRecognizerDirection.right:
                print("did swipe right")
                self.isCorrect(self.currentActionGesture == .rightSwipe)
                
            default:
                print("was not left/right")
                self.isCorrect(false)
            }
        }
        
        
    }
    
    //game timer that starts after first move is made
    func gameTimer(){
        self.timerLabel.text = "\u{23F0}:" + String(gameTime)
        
        if userWin(){
            gameOfEnd(display: "YOU WIN!!")
        }
        else if gameTime == 0{
            gameOfEnd(display: "YOU LOSE!!")
            gameTime = 10
        
        }else{
            gameTime -= 1
        }
        
      
    }
    
    func startGame(){
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(gameTimer), userInfo: nil, repeats: true)
        enableControls(state: true)
    }
    
    func gameOfEnd(display: String){
        timer.invalidate()
        enableControls(state: false)
        tapGestureRecognizer.isEnabled = false
        actionToPerformLabel.text = display
    }
    
    func userWin()->Bool{
        return playerScore == winScore
    }
    
    func enableControls(state: Bool){
        timerLabel.isEnabled = state
        rightSwipeGestureRecognizer.isEnabled = state
        leftSwipeGestureRecognizer.isEnabled = state
       // tapGestureRecognizer.isEnabled = state
        doubleTapGestureRecognizer.isEnabled = state
        twoFingerTapGestureRecognizer.isEnabled = state
    }
}
