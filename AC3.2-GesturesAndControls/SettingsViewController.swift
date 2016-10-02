//
//  SettingsViewController.swift
//  AC3.2-GesturesAndControls
//
//  Created by Jason Gresh on 9/29/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    class Color {
        var red: Double
        var green: Double
        var blue: Double
        var alpha: Double
        
        init(){
            self.red = 0.0
            self.green = 0.0
            self.blue = 0.0
            self.alpha = 1.0
        }
        
        func setColor(red: Double, green: Double, blue: Double, alpha: Double){
            self.red = red
            self.green = green
            self.blue = blue
            self.alpha = alpha
        }
        func getColor() -> UIColor {
            return UIColor(red: CGFloat(self.red), green: CGFloat(self.green), blue: CGFloat(self.blue), alpha: CGFloat(self.alpha))
        }
    }
    
    var colorForRight = Color()
    var colorForWrong = Color()
    
    @IBOutlet weak var redColorSlider: UISlider!
    @IBOutlet weak var greenColorSlider: UISlider!
    @IBOutlet weak var blueColorSlider: UISlider!
    @IBOutlet weak var rightFeedbackLabel: UILabel!
    @IBOutlet weak var wrongFeedbackLabel: UILabel!
    @IBOutlet weak var resetIndecator: UILabel!
    @IBOutlet weak var winningScoreDisplay: UILabel!
    
    @IBOutlet weak var resetSwitch: UISwitch!
    @IBOutlet weak var winningScoreStepper: UIStepper!
    @IBOutlet weak var rightAndWrongColorSegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rightFeedbackLabel.text = "Preview"
        self.wrongFeedbackLabel.text = "Preview"
        self.resetIndecator.text = "Reset mode ON"
        self.winningScoreDisplay.text = "Winning score: \(Int(winningScoreStepper.value))"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let gvc = segue.destination as? GesturesViewController {
            gvc.correctColorForRight = colorForRight.getColor()
            gvc.correctColorForWrong = colorForWrong.getColor()
            gvc.winningScoree = Int(winningScoreStepper.value)
            if resetSwitch.isOn{
                gvc.resetMode = true
            }else{
                gvc.resetMode = false
            }
        }
    }
    @IBAction func modeSwitch(_ sender: UISwitch) {
        if sender.isOn{
            resetIndecator.text = "Reset mode ON"
        }else{
            resetIndecator.text = "Reset mode OFF"
        }
    }
    @IBAction func setWinningScore(_ sender: UIStepper) {
        winningScoreDisplay.text = "Winning score: \(Int(sender.value))"
    }
    
    @IBAction func rightAndWrongColorSwitch(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            redColorSlider.value = Float(self.colorForRight.red)
            greenColorSlider.value = Float(self.colorForRight.green)
            blueColorSlider.value = Float(self.colorForRight.blue)
        case 1:
            redColorSlider.value = Float(self.colorForWrong.red)
            greenColorSlider.value = Float(self.colorForWrong.green)
            blueColorSlider.value = Float(self.colorForWrong.blue)
        default:
            break
        }
    }
    
    
    @IBAction func feedbackLabelPreview(_ sender: UISlider) {
        switch rightAndWrongColorSegment.selectedSegmentIndex {
        case 0:
            self.rightFeedbackLabel.backgroundColor = UIColor(red: CGFloat(self.redColorSlider.value), green: CGFloat(greenColorSlider.value), blue: CGFloat(blueColorSlider.value), alpha: 1.0)
            
            colorForRight.setColor(red: Double(redColorSlider.value), green: Double(greenColorSlider.value), blue: Double(blueColorSlider.value), alpha: 1.0)
            
        case 1:
            self.wrongFeedbackLabel.backgroundColor = UIColor(red: CGFloat(self.redColorSlider.value), green: CGFloat(greenColorSlider.value), blue: CGFloat(blueColorSlider.value), alpha: 1.0)
            
            colorForWrong.setColor(red: Double(redColorSlider.value), green: Double(greenColorSlider.value), blue: Double(blueColorSlider.value), alpha: 1.0)
        default:
            break
        }
    }
}
