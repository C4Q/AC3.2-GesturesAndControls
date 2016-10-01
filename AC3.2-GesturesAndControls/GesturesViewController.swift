//
//  GesturesViewController.swift
//  AC3.2-GesturesAndControls
//
//  Created by Sabrina Ip on 9/29/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class GesturesViewController: UIViewController {
    
    var correctColorValue = 0.0
    
    enum ActionGesture: Int {
        case tap, doubleTap, twoFingerTap, leftSwipe, rightSwipe
    }
    
    var currentActionGesture = ActionGesture.tap {
        willSet {
            self.updateLabel(for: newValue)
        }
    }
    
    var currentScore = 0 {
        willSet {
            self.scoreLabel.text = "Score: \(newValue)"
        }
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var actionToPerformLabel: UILabel!
    
    @IBOutlet var tapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet var rightSwipeGestureRecognizer: UISwipeGestureRecognizer!
    @IBOutlet var leftSwipeGestureRecognizer: UISwipeGestureRecognizer!
    @IBOutlet var doubleTapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet var twoFingerTapGesture: UITapGestureRecognizer!
    
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
    
/* Refactor the following into one action function
    @IBAction func didTapView(_ sender: UITapGestureRecognizer) {
        print("I was tapped")
        self.isCorrect(self.currentActionGesture == .tap)
    }

    @IBAction func swipedRight(_ sender: UISwipeGestureRecognizer) {
        print("swiped right")
        self.isCorrect(self.currentActionGesture == .rightSwipe)
    }
    
    @IBAction func swipedLeft(_ sender: UISwipeGestureRecognizer) {
        print("swiped left")
        self.isCorrect(self.currentActionGesture == .leftSwipe)
    }
    
    @IBAction func doubleTapped(_ sender: UITapGestureRecognizer) {
        print("double tapped")
        self.isCorrect(self.currentActionGesture == .doubleTap)
    }
    
    @IBAction func twoFingerTapped(_ sender: UITapGestureRecognizer) {
        print("Two finger tapped")
        self.isCorrect(self.currentActionGesture == .twoFingerTap)
    }
 */
    
    @IBAction func didPerformGesture(_ sender: UIGestureRecognizer) {
        if let tapGesture: UITapGestureRecognizer = sender as? UITapGestureRecognizer {
            //do stuff
            switch(tapGesture.numberOfTapsRequired, tapGesture.numberOfTouchesRequired) {
            case (1, 1):
                print("tapped!")
                self.isCorrect(self.currentActionGesture == .tap)
            case (2, 1):
                print("double tapped!")
                self.isCorrect(self.currentActionGesture == .doubleTap)
            case (1, 2):
                print("two finger tapped!")
                self.isCorrect(self.currentActionGesture == .twoFingerTap)
            default:
                print("tap type was wrong!")
                self.isCorrect(false)
            }
        } else if let swipeGesture: UISwipeGestureRecognizer = sender as? UISwipeGestureRecognizer {
            //do other stuff
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.left:
                print("swiped left!")
                self.isCorrect(self.currentActionGesture == .leftSwipe)
            case UISwipeGestureRecognizerDirection.right:
                print("swiped right!")
                self.isCorrect(self.currentActionGesture == .rightSwipe)
            default:
                print("swipe was wrong!")
                self.isCorrect(false)
            }
        }
    }
    
    func isCorrect(_ correct: Bool) {
        self.currentActionGesture = pickRandomActionGesture()
        
        if correct {
            self.view.backgroundColor = .green
            self.currentScore += 1
        } else {
            self.view.backgroundColor = .red
            self.currentScore = 0
        }
    }
}
