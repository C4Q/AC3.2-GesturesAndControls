//
//  SettingsViewController.swift
//  AC3.2-GesturesAndControls
//
//  Created by Jason Gresh on 9/29/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    var correctcolor = UIColor.white
    var wrongColor = UIColor.white
    var resetScore = true
    var minScoreForWin = 10
   
    @IBOutlet weak var redColorSlider: UISlider!
    @IBOutlet weak var greenColorSlider: UISlider!
    @IBOutlet weak var blueColorSlider: UISlider!
    @IBOutlet weak var colorPreview: UIView!
    @IBOutlet weak var zeroScoreSwitch: UISwitch!
    @IBOutlet weak var minForWinLabel: UILabel!
    @IBOutlet weak var wrongOrRightColorSegement: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let gvc = segue.destination as? GesturesViewController {
            gvc.correctColorValue = correctcolor
            gvc.wrongColorValue = wrongColor
            gvc.switchingScore = resetScore
            gvc.minScoreForWin = minScoreForWin
            
            
        }
    }
    
    func makingCorrectColor() {
        let red = CGFloat(redColorSlider.value)
        let blue = CGFloat(blueColorSlider.value)
        let green = CGFloat (greenColorSlider.value)
        let color = UIColor(red:red, green:green, blue:blue, alpha:1.0)
        correctcolor = color
        colorPreview.backgroundColor = color
    }
    func makingWrongColor() {
        let red = CGFloat(redColorSlider.value)
        let blue = CGFloat(blueColorSlider.value)
        let green = CGFloat (greenColorSlider.value)
        let color = UIColor(red:red, green:green, blue:blue, alpha:1.0)
        wrongColor = color
        colorPreview.backgroundColor = color
    }
    
    
    @IBAction func redSliderMoved(_ sender: UISlider) {
        if wrongOrRightColorSegement.selectedSegmentIndex == 0 {
            makingCorrectColor()
        }else if wrongOrRightColorSegement.selectedSegmentIndex == 1 {
            makingWrongColor()
        }
    }
    
    @IBAction func greenSliderMoved(_ sender: UISlider) {
        if wrongOrRightColorSegement.selectedSegmentIndex == 0 {
            makingCorrectColor()
        }else if wrongOrRightColorSegement.selectedSegmentIndex == 1 {
            makingWrongColor()
        }

    }
    
    @IBAction func blueSliderMoved(_ sender: UISlider) {
        if wrongOrRightColorSegement.selectedSegmentIndex == 0 {
            makingCorrectColor()
        }else if wrongOrRightColorSegement.selectedSegmentIndex == 1 {
            makingWrongColor()
        }
    }
    
    
    @IBAction func switchingTypeOfScore(_ sender: UISwitch) {
        if sender.isOn {
            resetScore = true
        } else {
            resetScore = false
            
        }
    
    }
    @IBAction func minScore(_ sender: UIStepper) {
        minScoreForWin = Int(sender.value)
        minForWinLabel.text = ("You need \(Int(sender.value)) right answers to win")
    }
    
    @IBAction func settingWrongAndRightColor(_ sender: UISegmentedControl) {
        switch wrongOrRightColorSegement.selectedSegmentIndex {
        case 0:
           makingCorrectColor()
            colorPreview.backgroundColor = correctcolor
            
        case 1:
           makingWrongColor()
           colorPreview.backgroundColor = wrongColor
        default:
            colorPreview.backgroundColor = UIColor.white
        }
    }
    
}
