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
	var currectColor = UIColor.white
	var winCount = 0
	
	@IBOutlet weak var rightWrongColors: UISegmentedControl!
	
	@IBOutlet weak var redSlider: UISlider!
	@IBOutlet weak var greenSlider: UISlider!
	@IBOutlet weak var blueSlider: UISlider!
	
	@IBOutlet weak var colorPreview: UIView!
	
	@IBOutlet weak var resetSwitch: UISwitch!
	@IBOutlet weak var resetLabel: UILabel!

	@IBOutlet weak var winCountStepper: UIStepper!
	@IBOutlet weak var winCountLabel: UILabel!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		// Do any additional setup after loading the view.
		colorPreview.backgroundColor = currectColor
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let gvc = segue.destination as? GesturesViewController {
            gvc.correctColor = correctColor
			gvc.wrongColor = wrongColor
			gvc.reset = resetSwitch.isOn
			gvc.winCount = winCount
		}
    }
	
	// MARK: Color Stuff
	var correctRedSlider = 0.0
	var correctGreenSlider = 1.0
	var correctBlueSlider = 0.0
	var wrongRedSlider = 1.0
	var wrongGreenSlider = 0.5
	var wrongBlueSlider = 0.5
	var rightWrongPicked = true
	
	@IBAction func colorChange(_ sender: UISlider) {
		currectColor = UIColor(red: CGFloat(Double(redSlider.value)), green: CGFloat(Double(greenSlider.value)), blue: CGFloat(Double(blueSlider.value)), alpha: 1.0)
		colorPreview.backgroundColor = currectColor
		
		if rightWrongColors.selectedSegmentIndex == 0 {
			correctColor = currectColor
		} else {
			wrongColor = currectColor
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
