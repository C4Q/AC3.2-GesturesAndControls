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
    @IBOutlet weak var colorPreviewLabel: UILabel!
    @IBOutlet weak var rightOrWrongSegmentControl: UISegmentedControl!
    @IBOutlet weak var switchPreviewLabel: UILabel!
    @IBOutlet weak var minScoreToWinLabel: UILabel!
    
    var rightColorOutput = UIColor.white
    var wrongColorOutput = UIColor.white
    var redColorFloat: CGFloat = 0.5
    var greenColorFloat: CGFloat = 0.5
    var blueColorFloat: CGFloat = 0.5
    var scoreResetBool = true
    var minScoreToWin = 10
    
    @IBAction func colorSetForRightOrWrongCondition(_ sender: UISegmentedControl) {
        //let willSetColor = UIColor(red: redColorFloat, green: greenColorFloat, blue: blueColorFloat, alpha: 1.0)

        switch rightOrWrongSegmentControl.selectedSegmentIndex{
        case 0:
            print("redslider \(redColorSlider.value) \n greenslider \(greenColorSlider.value) \n blueslider \(blueColorSlider.value)")
            rightColorOutput = UIColor(red: redColorFloat, green: greenColorFloat, blue: blueColorFloat, alpha: 1.0)
            colorPreviewLabel.backgroundColor = rightColorOutput
            //rightColorOutput = willSetColor
            //rightColorOutput = UIColor(red: CGFloat(redColorSlider.value), green: CGFloat(self.greenColorSlider.value), blue: CGFloat(self.blueColorSlider.value), alpha: 1.0)
        case 1:
            wrongColorOutput = UIColor(red: redColorFloat, green: greenColorFloat, blue: blueColorFloat, alpha: 1.0)
            colorPreviewLabel.backgroundColor = wrongColorOutput
            //wrongColorOutput = willSetColor
            //wrongColorOutput = UIColor(red: CGFloat(redColorSlider.value), green: CGFloat(self.greenColorSlider.value), blue: CGFloat(self.blueColorSlider.value), alpha: 1.0)
        default:
            rightColorOutput = UIColor(red: redColorFloat, green: greenColorFloat, blue: blueColorFloat, alpha: 1.0)
            colorPreviewLabel.backgroundColor = rightColorOutput
            //rightColorOutput = willSetColor
            //rightColorOutput = UIColor(red: CGFloat(redColorSlider.value), green: CGFloat(self.greenColorSlider.value), blue: CGFloat(self.blueColorSlider.value), alpha: 1.0)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorPreviewLabel.backgroundColor = UIColor(red: redColorFloat, green: greenColorFloat, blue: blueColorFloat, alpha: 1.0)
        colorSetForRightOrWrongCondition(rightOrWrongSegmentControl)
        minScoreToWinLabel.text = "Minimum Score To Win \(minScoreToWin)"
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let gvc = segue.destination as? GesturesViewController {
            gvc.rightColor = rightColorOutput
            gvc.wrongColor = wrongColorOutput
            gvc.scoreResetSwitch = scoreResetBool
            gvc.minScoreToWin = minScoreToWin
            //            gvc.redColorValue = Double(redColorSlider.value)
            //            gvc.greenColorValue = Double(greenColorSlider.value)
            //            gvc.blueColorValue = Double(blueColorSlider.value)
            //            colorPreviewLabel.backgroundColor = gvc.correctColor
            
        }
    }
    
    @IBAction func redSliderUpdateValue(_ sender: UISlider) {
        sender.setValue((sender.value), animated: true)
        redColorFloat = CGFloat(sender.value)
        colorPreviewLabel.backgroundColor = UIColor(red: redColorFloat, green: greenColorFloat, blue: blueColorFloat, alpha: 1.0)
    }
    
    @IBAction func greenSliderUpdateValue(_ sender: UISlider) {
        sender.setValue((sender.value), animated: true)
        greenColorFloat = CGFloat(sender.value)
        colorPreviewLabel.backgroundColor = UIColor(red: redColorFloat, green: greenColorFloat, blue: blueColorFloat, alpha: 1.0)
    }
    
    @IBAction func blueSliderUpdate(_ sender: UISlider) {
        sender.setValue((sender.value), animated: true)
        blueColorFloat = CGFloat(sender.value)
        colorPreviewLabel.backgroundColor = UIColor(red: redColorFloat, green: greenColorFloat, blue: blueColorFloat, alpha: 1.0)
    }
    
    @IBAction func scoreReset(_ sender: UISwitch) {
        if sender.isOn {
            scoreResetBool = true
            switchPreviewLabel.text = "Score Reset On"
        } else {
            scoreResetBool = false
            switchPreviewLabel.text = "Score Reset Off"
        }
    }
    
    @IBAction func minScoreUpdateStepper(_ sender: UIStepper) {
        minScoreToWinLabel.text = "Minimum Score To Win \(Int(sender.value))"
        minScoreToWin = Int(sender.value)
    }
    
    
    
}
