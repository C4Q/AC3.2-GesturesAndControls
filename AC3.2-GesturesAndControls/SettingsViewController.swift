//
//  SettingsViewController.swift
//  AC3.2-GesturesAndControls
//
//  Created by Jason Gresh on 9/29/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var intialColor = 0
    
    @IBAction func homeSegmented(_ sender: UISegmentedControl) {
    }

    @IBOutlet weak var colorSlider: UISlider!
    
    
    @IBAction func colorSliderOne(_ sender: UISlider) {
    }
    
    @IBAction func colorSliderTwo(_ sender: UISlider) {
        print("\(sender.value)")
    }

    @IBAction func colorSliderThree(_ sender: UISlider) {
    }
    
    
    @IBOutlet weak var colorLabel: UILabel!

    
    @IBAction func homeSwitch(_ sender: UISwitch) {
    }
    
    
    @IBAction func homeStepper(_ sender: UIStepper) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let gvc = segue.destination as? GesturesViewController {
            gvc.correctColorValue = Double(colorSlider.value)
        }
    }
}
