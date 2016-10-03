//
//  SettingsViewController.swift
//  AC3.2-GesturesAndControls
//
//  Created by Jason Gresh on 9/29/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var redColorSlider: UISlider!
    @IBOutlet weak var greenColorSlider: UISlider!
    @IBOutlet weak var blueColorSlider: UISlider!
    @IBOutlet weak var previewColorView: UIView!
    @IBOutlet weak var resetToggleSwitch: UISwitch!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var switchLabel: UILabel!
    @IBOutlet weak var stepperLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var instructionsTextView: UITextView!
    
    var rgbColor: UIColor {
        let red = CGFloat(redColorSlider.value)
        let green = CGFloat(greenColorSlider.value)
        let blue = CGFloat(blueColorSlider.value)
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        return color
    }
    var resetSwitchIsOn: Bool = true
    var numberOfAttempts: Double = 0
    let gvc: GesturesViewController = GesturesViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        previewColorView.backgroundColor = rgbColor
        resetToggleSwitch.isOn = true
        switchLabel.text = "Reset: on"
    }
    
    func wrongSegmentHandler(gvc: GesturesViewController) {
        if segmentedControl.selectedSegmentIndex == 0 {
            gvc.rightColor = rgbColor
            gvc.wrongColor = .red
        }
        else {
            gvc.rightColor = .green
            gvc.wrongColor = rgbColor
        }
    }
    
    //MARK: - Actions
    @IBAction func redColorSliderValueChanged(_ sender: UISlider) {
        previewColorView.backgroundColor = UIColor(red: CGFloat(sender.value), green: CGFloat(greenColorSlider.value), blue: CGFloat(blueColorSlider.value), alpha: 1.0)
    }
    @IBAction func greenColorSliderValueChanged(_ sender: UISlider) {
        previewColorView.backgroundColor = UIColor(red: CGFloat(redColorSlider.value), green: CGFloat(sender.value), blue: CGFloat(blueColorSlider.value), alpha: 1.0)
    }
    @IBAction func blueColorSliderValueChanged(_ sender: UISlider) {
        previewColorView.backgroundColor = UIColor(red: CGFloat(redColorSlider.value), green: CGFloat(greenColorSlider.value), blue: CGFloat(sender.value), alpha: 1.0)
    }
    @IBAction func resetToggleSwitchValueChanged(_ sender: UISwitch) {
        if resetToggleSwitch.isOn {
            gvc.resetToggle = true
            switchLabel.text = "Reset: on"
        }
        else {
            gvc.resetToggle = false
            switchLabel.text = "Reset: off"
        }
    }
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        stepperLabel.text = String(Int(sender.value))
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let gvc = segue.destination as? GesturesViewController {
            if !resetToggleSwitch.isOn {
                gvc.resetToggle = false
            }
            wrongSegmentHandler(gvc: gvc)
            gvc.winningNumber = Int(stepper.value)
        }
    }
}
