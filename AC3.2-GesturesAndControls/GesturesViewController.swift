//
//  GesturesViewController.swift
//  AC3.2-GesturesAndControls
//
//  Created by Jason Gresh on 9/29/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class GesturesViewController: UIViewController {
    /*
     \/Using the single UISlider we're using as a model, add two more UISliders to control red, green and blue values individually. Instead of passing a number to the detail, send at UIColor object that you create based on these three values.
     \/In real time, preview the color being manipulated in a UIView in the master. You'll do this by continuously updating the value of the background color of the preview UIView on change value events from all sliders.
     \/Add a UISwitch that will determine whether or not to reset the score to zero on wrong guesses. If on, it will do what it's doing now: reset. When off it will just keep counting up.
     \/Add a UIStepper to set the number of consecutive tries before winning. After winning, reset the score to zero.
     \/Add a UISegmentedControl to configure which of the right/wrong colors you're setting. This will require another property to hold the color for wrong answers. At this point your application will look something like this:
     \/Add titles and feedback in the form of UILabels to help the user know what's what. E.g. mark what the switch does; show the value of the stepper.
 
    */
    
    var rightColor = UIColor.white
    var wrongColor = UIColor.white
    var scoreResetSwitch = true
    var minScoreToWin = 10
    
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
        self.scoreLabel.text = "Score: 0"

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
                self.isCorrect(self.currentActionGesture == .tap, scoreResetSwitch)
                
            case (2, 1):
                print("double tap!")
                self.isCorrect(self.currentActionGesture == .doubleTap, scoreResetSwitch)
                
            case (1, 2):
                print("two finger tap!")
                self.isCorrect(self.currentActionGesture == .twoFingerTap, scoreResetSwitch)
                
            default:
                print("tap type was wrong!")
                self.isCorrect(false, scoreResetSwitch)
            }
        }
    
        if let swipeGesture: UISwipeGestureRecognizer = sender as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
                
            case UISwipeGestureRecognizerDirection.left:
                print("did swipe left")
                self.isCorrect(self.currentActionGesture == .leftSwipe, scoreResetSwitch)
                
            case UISwipeGestureRecognizerDirection.right:
                print("did swipe right")
                self.isCorrect(self.currentActionGesture == .rightSwipe, scoreResetSwitch)
                
            default:
                print("was not left/right")
                self.isCorrect(false, scoreResetSwitch)
            }
        }
    }
    
    func isCorrect(_ correct: Bool, _ resetScore: Bool) {
        self.currentActionGesture = pickRandomActionGesture()
        if correct {
            self.view.backgroundColor = rightColor
            self.currentScore += 1
            if self.currentScore == self.minScoreToWin {
                self.currentScore = 0
                scoreLabel.text = "You win!"
            }
            // use the "correctColorValue" to manipulate the red component of a color
            // correctColor = UIColor(red: CGFloat(self.redColorValue), green: CGFloat(self.greenColorValue), blue: CGFloat(self.blueColorValue), alpha: 1.0)
            
            // alternatively we can change the hue using this initializer of UIColor
            // self.view.backgroundColor = UIColor(hue: CGFloat(Float(self.correctColorValue)), saturation: 1.0, brightness: 1.0, alpha: 1.0)
        } else if !correct && resetScore {
            self.view.backgroundColor = wrongColor
            self.currentScore = 0
            //self.view.backgroundColor = UIColor.red
        } else if !correct && !resetScore {
            self.view.backgroundColor = wrongColor
            self.currentScore += 0
        }
    }
}
