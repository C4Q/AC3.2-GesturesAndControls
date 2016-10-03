//
//  SettingsViewController.swift
//  AC3.2-GesturesAndControls
//
//  Created by Jason Gresh on 9/29/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
	var correctColor = UIColor.green
	var wrongColor = UIColor.red
	var colorChoice = UIColor.white
	var winCount = Int()
	
	@IBOutlet weak var rightWrongColors: UISegmentedControl!
	
	@IBOutlet weak var redSlider: UISlider!
	@IBOutlet weak var greenSlider: UISlider!
	@IBOutlet weak var blueSlider: UISlider!
	
	@IBOutlet weak var colorPreviewCorrect: UIView!
	@IBOutlet weak var colorPreviewWrong: UIView!
	
	@IBOutlet weak var resetSwitch: UISwitch!
	@IBOutlet weak var resetLabel: UILabel!
	
	@IBOutlet weak var winCountStepper: UIStepper!
	@IBOutlet weak var winCountLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		colorPreviewCorrect.backgroundColor = UIColor.green
		colorPreviewWrong.backgroundColor = UIColor.red
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	// MARK: - Navigation
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let gvc = segue.destination as? GesturesViewController {
			// If user doesn't set custom colors, initial values will be used
			gvc.correctColor = correctColor
			gvc.wrongColor = wrongColor
			gvc.reset = resetSwitch.isOn
			gvc.winCount = winCount
		}
	}
	
	// MARK: Color Stuff
	var correctRedSlider:CGFloat = 0.0
	var correctGreenSlider:CGFloat = 0.0
	var correctBlueSlider:CGFloat = 0.0
	var wrongRedSlider:CGFloat = 0.0
	var wrongGreenSlider:CGFloat = 0.0
	var wrongBlueSlider:CGFloat = 0.0
	var alpha:CGFloat = 0.0
	
	@IBAction func colorSegment(_ sender: UISegmentedControl) {
		if sender.selectedSegmentIndex == 0 {
			if correctColor.getRed(&correctRedSlider, green: &correctGreenSlider, blue: &correctBlueSlider, alpha: &alpha) {
				redSlider.value = Float(correctRedSlider)
				greenSlider.value = Float(correctGreenSlider)
				blueSlider.value = Float(correctBlueSlider)
			}
		} else {
			if wrongColor.getRed(&wrongRedSlider, green: &wrongGreenSlider, blue: &wrongBlueSlider, alpha: &alpha) {
				redSlider.value = Float(wrongRedSlider)
				greenSlider.value = Float(wrongGreenSlider)
				blueSlider.value = Float(wrongBlueSlider)
			}
		}
	}
	
	@IBAction func colorChange(_ sender: UISlider) {
		colorChoice = UIColor(red: CGFloat(Double(redSlider.value)), green: CGFloat(Double(greenSlider.value)), blue: CGFloat(Double(blueSlider.value)), alpha: 1.0)
		
		if rightWrongColors.selectedSegmentIndex == 0 {
			correctColor = colorChoice
			colorPreviewCorrect.backgroundColor = colorChoice
		} else {
			wrongColor = colorChoice
			colorPreviewWrong.backgroundColor = colorChoice
		}
	}
	
	@IBAction func resetSwitchOption(_ sender: UISwitch) {
		if sender.isOn {
			resetLabel.text = "Reset When Wrong: On"
		} else {
			resetLabel.text = "Reset When Wrong: Off"
		}
	}
	
	@IBAction func winCountOption(_ sender: UIStepper) {
		if sender.value == 0 {
			winCountLabel.text = "Points Until Victory: Endless Mode"
		} else {
			winCountLabel.text = "Points Until Victory: \(Int(sender.value))"
		}
		winCount = Int(sender.value)
	}
}
