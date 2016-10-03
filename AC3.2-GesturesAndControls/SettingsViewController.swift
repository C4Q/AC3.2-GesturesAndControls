//
//  SettingsViewController.swift
//  AC3.2-GesturesAndControls
//
//  Created by Jason Gresh on 9/29/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var score = Int()
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var colorBoxField: UILabel!

    @IBAction func colorAction(_ sender: UISlider) {
          colorBoxField.backgroundColor = UIColor(red: CGFloat(self.redSlider.value), green: CGFloat(self.greenSlider.value), blue: CGFloat(self.blueSlider.value), alpha: 1.0)
    }
    
    @IBOutlet weak var rightWrongSegment: UISegmentedControl!
    
    @IBOutlet weak var counterReset: UISwitch!


    @IBOutlet weak var winningTriesSetter: UIStepper!
    
   
    @IBAction func counter(_ sender: UIStepper) {
        
    colorBoxField.text = String(winningTriesSetter.value)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Do any additional setup after loading the view.
    }

    @IBAction func counterResetSwitch(_ sender: UISwitch) {
      
       
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let gvc = segue.destination as? GesturesViewController {
            
            switch rightWrongSegment.selectedSegmentIndex
            {
            case 0:
                gvc.correctRedValue = Double(redSlider.value)
                gvc.correctGreenValue = Double(greenSlider.value)
                gvc.correctBlueValue = Double(blueSlider.value)
            case 1:
                gvc.incorrectRedValue = Double(redSlider.value)
                gvc.incorrectGreenValue = Double(greenSlider.value)
                gvc.incorrectBlueValue = Double(blueSlider.value)
            default:
                break;
            }
            
            if !counterReset.isOn {
                gvc.shouldReset = .noReset
            }
            
            gvc.numOfTriesToWin = Int(winningTriesSetter.value)
        
        }
    }
}
