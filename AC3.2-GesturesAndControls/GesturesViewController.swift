//
//  GesturesViewController.swift
//  AC3.2-GesturesAndControls
//
//  Created by Jason Gresh on 9/29/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class GesturesViewController: UIViewController {
    var correctRedColorValue = 0.0
    var correctGreenColorValue = 1.0
    var correctBlueColorValue = 0.0
    var incorrectRedColorValue = 1.0
    var incorrectGreenColorValue = 0.0
    var incorrectBlueColorValue = 0.0
    
    var difficultySwitchIsOn = true
    var scoreForWin = 10
    
    enum ActionGesture: Int {
        case tap, doubleTap, twoFingerTap, leftSwipe, rightSwipe, upSwipe, downSwipe
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
    
    @IBOutlet var downSwipeGestureRecognizer: UISwipeGestureRecognizer!
    @IBOutlet var upSwipeGestureRecognizer: UISwipeGestureRecognizer!
    
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
        case .upSwipe: updateText = "swipe up"
        case .downSwipe: updateText = "swipe down"
        }
        self.actionToPerformLabel.text = updateText
    }
    
    // a way to randomly get a gesture
    func pickRandomActionGesture() -> ActionGesture {
        let randomInt = Int(arc4random_uniform(7)) // number between 0-6
        return ActionGesture(rawValue: randomInt) ?? .tap
    }
    
    // MARK: - Actions
    
    @IBAction func didPerformGesture(_ sender: UIGestureRecognizer) {
        if currentScore >= scoreForWin { return }
        
        if let tapGesture: UITapGestureRecognizer = sender as? UITapGestureRecognizer {
            switch (tapGesture.numberOfTapsRequired, tapGesture.numberOfTouchesRequired) {
            case (1, 1):
                self.isCorrect(self.currentActionGesture == .tap)
            case (2, 1):
                self.isCorrect(self.currentActionGesture == .doubleTap)
            case (1, 2):
                self.isCorrect(self.currentActionGesture == .twoFingerTap)
            default:
                self.isCorrect(false)
            }
        }
        if let swipeGesture: UISwipeGestureRecognizer = sender as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.left:
                self.isCorrect(self.currentActionGesture == .leftSwipe)
            case UISwipeGestureRecognizerDirection.right:
                self.isCorrect(self.currentActionGesture == .rightSwipe)
            case UISwipeGestureRecognizerDirection.up:
                self.isCorrect(self.currentActionGesture == .upSwipe)
            case UISwipeGestureRecognizerDirection.down:
                self.isCorrect(self.currentActionGesture == .downSwipe)
            default:
                self.isCorrect(false)
            }
        }
    }
    
    func isCorrect(_ correct: Bool) {
        self.currentActionGesture = pickRandomActionGesture()
        if correct {
            self.view.backgroundColor = UIColor(red: CGFloat(self.correctRedColorValue), green: CGFloat(self.correctGreenColorValue), blue: CGFloat(self.correctBlueColorValue), alpha: 1.0)
            self.currentScore += 1
        }
        else {
            self.view.backgroundColor = UIColor(red: CGFloat(self.incorrectRedColorValue), green: CGFloat(self.incorrectGreenColorValue), blue: CGFloat(self.incorrectBlueColorValue), alpha: 1.0)
            if difficultySwitchIsOn {
                self.currentScore = 0
            }
        }
        if self.currentScore >= scoreForWin {
            self.actionToPerformLabel.text = "WINNER"
        }
    }
}
