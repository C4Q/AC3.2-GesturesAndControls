//
//  SettingsViewController.swift
//  AC3.2-GesturesAndControls
//
//  Created by Jason Gresh on 9/29/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak private var rightWrongSegmentControl: UISegmentedControl!
    @IBOutlet weak private var redColorSlider: UISlider!
    @IBOutlet weak private var greenColorSlider: UISlider!
    @IBOutlet weak private var blueColorSlider: UISlider!
    @IBOutlet weak private var colorPreview: UIView!
    @IBOutlet weak private var resetToZero: UISwitch!
    @IBOutlet weak private var winningScoreStepper: UIStepper!
    @IBOutlet weak private var winningScoreLabel: UILabel!
    
    private var currentColor = UIColor.white
    private var rightColor = UIColor.green
    private var wrongColor = UIColor.red
    
//    ****
    private var winningScore = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorPreview.backgroundColor  = UIColor(red: CGFloat(Double(redColorSlider.value)), green: CGFloat(Double(greenColorSlider.value)), blue: CGFloat(Double(blueColorSlider.value)), alpha: 1.0)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let gvc = segue.destination as? GesturesViewController {
            gvc.correctColor = rightColor
            gvc.wrongColor = wrongColor
            gvc.scoreResets = resetToZero.isOn
            gvc.winningScore = winningScore
        }
    }
    
    @IBAction private func rightWrongColorSegmentIsChanged(_ sender: UISegmentedControl) {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0

        if rightWrongSegmentControl.selectedSegmentIndex == 0 {
            colorPreview.backgroundColor = rightColor
            if rightColor.getRed(&r, green: &g, blue: &b, alpha: &a) {
                redColorSlider.value = Float(r)
                greenColorSlider.value = Float(g)
                blueColorSlider.value = Float(b)
            }
        } else if rightWrongSegmentControl.selectedSegmentIndex == 1 {
            colorPreview.backgroundColor = wrongColor
            if wrongColor.getRed(&r, green: &g, blue: &b, alpha: &a) {
                redColorSlider.value = Float(r)
                greenColorSlider.value = Float(g)
                blueColorSlider.value = Float(b)
            }
        }
    }
    
    @IBAction private func colorChanged(_ sender: UISlider) {
        currentColor = UIColor(red: CGFloat(Double(redColorSlider.value)), green: CGFloat(Double(greenColorSlider.value)), blue: CGFloat(Double(blueColorSlider.value)), alpha: 1.0)
        colorPreview.backgroundColor = currentColor
        
        if rightWrongSegmentControl.selectedSegmentIndex == 0 {
            rightColor = currentColor
        } else if rightWrongSegmentControl.selectedSegmentIndex == 1 {
            wrongColor = currentColor
        }
    }
    
    @IBAction private func updateWinningScore(_ sender: UIStepper) {
        winningScore = Int(winningScoreStepper.value)
        winningScoreLabel.text = "Winning Score: \(winningScore)"
    }
}
