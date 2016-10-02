//
//  SettingsViewController.swift
//  AC3.2-GesturesAndControls
//
//  Created by Jason Gresh on 9/29/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var redColorSlider: UISlider!
    @IBOutlet weak var greenColorSlider: UISlider!
    @IBOutlet weak var blueColorSlider: UISlider!
    @IBOutlet weak var colorPreviewView: UIView!
    @IBOutlet weak var winScoreLabel: UILabel!
    @IBOutlet weak var winScoreStepper: UIStepper!
    @IBOutlet weak var rightWrongColorSegment: UISegmentedControl!
    
    @IBOutlet weak var scoreResetLabel: UILabel!
    
    var difficultySwitchIsOn = true
    var rightRedVal = 0.5
    var rightGreenVal = 0.5
    var rightBlueVal = 0.5
    var wrongRedVal = 0.5
    var wrongGreenVal = 0.5
    var wrongBlueVal = 0.5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorPreviewView.backgroundColor = UIColor(red: CGFloat(redColorSlider.value), green: CGFloat(greenColorSlider.value), blue: CGFloat(blueColorSlider.value), alpha: 1.0)
        winScoreLabel.text = "Win Score: \(Int(winScoreStepper.value))"
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let gvc = segue.destination as? GesturesViewController {
            gvc.correctRedColorValue = rightRedVal
            gvc.correctGreenColorValue = rightGreenVal
            gvc.correctBlueColorValue = rightBlueVal
            gvc.incorrectRedColorValue = wrongRedVal
            gvc.incorrectGreenColorValue = wrongGreenVal
            gvc.incorrectBlueColorValue = wrongBlueVal
            gvc.difficultySwitchIsOn = difficultySwitchIsOn
            gvc.scoreForWin = Int(winScoreStepper.value)
        }
    }
    
    @IBAction func previewColorChange(_ sender: UISlider) {
        if rightWrongColorSegment.selectedSegmentIndex == 0 {
            rightRedVal = Double(redColorSlider.value)
            rightGreenVal = Double(greenColorSlider.value)
            rightBlueVal = Double(blueColorSlider.value)
            colorPreviewView.backgroundColor = UIColor(red: CGFloat(rightRedVal), green: CGFloat(rightGreenVal), blue: CGFloat(rightBlueVal), alpha: 1.0)
        } else {
            wrongRedVal = Double(redColorSlider.value)
            wrongGreenVal = Double(greenColorSlider.value)
            wrongBlueVal = Double(blueColorSlider.value)
            colorPreviewView.backgroundColor = UIColor(red: CGFloat(wrongRedVal), green: CGFloat(wrongGreenVal), blue: CGFloat(wrongBlueVal), alpha: 1.0)
        }
    }
    
    @IBAction func rightWrongColorSegmentTapped(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: //right
            redColorSlider.value = Float(rightRedVal)
            greenColorSlider.value = Float(rightGreenVal)
            blueColorSlider.value = Float(rightBlueVal)
            colorPreviewView.backgroundColor = UIColor(red: CGFloat(rightRedVal), green: CGFloat(rightGreenVal), blue: CGFloat(rightBlueVal), alpha: 1.0)
        case 1: //wrong
            redColorSlider.value = Float(wrongRedVal)
            greenColorSlider.value = Float(wrongGreenVal)
            blueColorSlider.value = Float(wrongBlueVal)
            colorPreviewView.backgroundColor = UIColor(red: CGFloat(wrongRedVal), green: CGFloat(wrongGreenVal), blue: CGFloat(wrongBlueVal), alpha: 1.0)
        default:
            break
        }
    }
    
    @IBAction func difficultySwitch(_ sender: UISwitch) {
        if sender.isOn {
            difficultySwitchIsOn = true
            scoreResetLabel.text = "Reset score for wrong answers: ON"
            
        } else {
            difficultySwitchIsOn = false
            scoreResetLabel.text = "Reset score for wrong answers: OFF"
        }        
    }
    
    @IBAction func winScoreStepper(_ sender: UIStepper) {
        winScoreLabel.text = "Win Score: \(Int(winScoreStepper.value))"
    }
    
}
