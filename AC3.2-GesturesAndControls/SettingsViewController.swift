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
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var resetSwtich: UISwitch!
    @IBOutlet weak var answerColorSegmentedControl: UISegmentedControl!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var scoreStepper: UIStepper!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorPreviewLabel.backgroundColor = getColor()
        hideSavePrompt(state: true)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func changeColorSlider(_ sender: UISlider) {
        colorPreviewLabel.backgroundColor = getColor()
        hideSavePrompt(state: false)
    }
    
    @IBAction func resetGameScoreSwitch(_ sender: UISwitch) {
        hideSavePrompt(state: false)
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
          hideSavePrompt(state: true)
    }
    
    @IBAction func changeGameWinScoreStepper(_ sender: UIStepper) {
        scoreLabel.text = String(Int(sender.value))
        hideSavePrompt(state: false)
    }
    
    
    
    func getColor()->UIColor{
        let red = redColorSlider.value
        let blue = blueColorSlider.value
        let green = greenColorSlider.value
        return UIColor(colorLiteralRed: red, green: green, blue: blue, alpha: 1.0)
    }
    
    func setColorSliders(color:UIColor){
        //redColorSlider.value
    }
    
    func hideSavePrompt(state: Bool){
        infoLabel.isHidden = state
        saveButton.isEnabled = !state
    }
    
//    func colorChoice()-> UIColor{
//        switch answerColorSegmentedControl. {
//        case "Right":
//            return getColor()
//        case "Wrong":
//            
//        default:
//            <#code#>
//        }
//    
//    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let gvc = segue.destination as? GesturesViewController {
           
            if answerColorSegmentedControl.selectedSegmentIndex == 0{
                gvc.correctColorValue = getColor()
            }
            
            if answerColorSegmentedControl.selectedSegmentIndex == 1{
                gvc.wrongColorValue = getColor()
            }
            
            gvc.resetScore = resetSwtich.isOn
            gvc.winScore = Int(scoreStepper.value)
            
            
            
        }
    }
}
