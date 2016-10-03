//
//  GesturesViewController.swift
//  AC3.2-GesturesAndControls
//
//  Created by Jason Gresh on 9/29/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class GesturesViewController: UIViewController {
    
    var minScoreForWin = 10
    var switchingScore = true
    var correctColorValue = UIColor.white
    var wrongColorValue = UIColor.white
    
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
            self.scoreLabel.text = "\(newValue)"
        }
    }
    
    @IBOutlet weak var actionToPerformLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var rightSwipeGestureRecognizer: UISwipeGestureRecognizer!
    @IBOutlet var leftSwipeGestureRecognizer: UISwipeGestureRecognizer!
    @IBOutlet var tapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet var doubleTapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet var twoFingerTapGestureRecognizer: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tapGestureRecognizer.require(toFail: doubleTapGestureRecognizer)
        self.currentActionGesture = self.pickRandomActionGesture()

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
//    @IBAction func didTapView(_ sender: UITapGestureRecognizer) {
//        print("I was tapped")
//        self.isCorrect(self.currentActionGesture == .tap)
//    }
//    
//    @IBAction func swipedLeft(_ sender: UISwipeGestureRecognizer) {
//        print("Swiped left")
//        self.isCorrect(self.currentActionGesture == .leftSwipe)
//    }
//    
//    @IBAction func swipedRight(_ sender: UISwipeGestureRecognizer) {
//        print("Swiped right")
//        self.isCorrect(self.currentActionGesture == .rightSwipe)
//    }
//    
//    @IBAction func didDoubleTapView(_ sender: UITapGestureRecognizer) {
//        print("Did double tap view")
//        self.isCorrect(self.currentActionGesture == .doubleTap)
//    }
//    
//    @IBAction func didTwoFingerTapView(_ sender: UITapGestureRecognizer) {
//        print("Did two finger tap view")
//        self.isCorrect(self.currentActionGesture == .twoFingerTap)
//    }
    
    @IBAction func didPerformGesture(_ sender: UIGestureRecognizer) {
        if let tapGesture: UITapGestureRecognizer = sender as? UITapGestureRecognizer {
            switch (tapGesture.numberOfTapsRequired, tapGesture.numberOfTouchesRequired) {
                
            case (1, 1):
                print("Heck yea I was tapped")
                self.isCorrect(self.currentActionGesture == .tap, switchingScore)
                
            case (2, 1):
                print("double tap!")
                self.isCorrect(self.currentActionGesture == .doubleTap, switchingScore)
                
            case (1, 2):
                print("two finger tap!")
                self.isCorrect(self.currentActionGesture == .twoFingerTap, switchingScore)
                
            default:
                print("tap type was wrong!")
                self.isCorrect(false, switchingScore)
            }
        }
    
        if let swipeGesture: UISwipeGestureRecognizer = sender as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
                
            case UISwipeGestureRecognizerDirection.left:
                print("did swipe left")
                self.isCorrect(self.currentActionGesture == .leftSwipe, switchingScore)
                
            case UISwipeGestureRecognizerDirection.right:
                print("did swipe right")
                self.isCorrect(self.currentActionGesture == .rightSwipe, switchingScore)
                
            default:
                print("was not left/right")
                self.isCorrect(false, switchingScore)
            }
        }
    }
    
    func isCorrect(_ correct: Bool , _ changingScore: Bool) {
        self.currentActionGesture = pickRandomActionGesture()
        if correct {
            self.view.backgroundColor = correctColorValue
            self.currentScore += 1
            if self.currentScore == self.minScoreForWin {
                self.currentScore = 0
                scoreLabel.text = "you win"
            }
        }
        else if !correct && changingScore {
            self.view.backgroundColor = wrongColorValue
            self.currentScore = 0
        }
        else if !correct && !changingScore {
            self.view.backgroundColor = wrongColorValue
            self.currentScore += 0
        }
    }
}
