//
//  SettingsViewController.swift
//  AC3.2-GesturesAndControls
//
//  Created by Jason Gresh on 9/29/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var colorSlider: UISlider!
    @IBOutlet weak var colorSlider2: UISlider!
    @IBOutlet weak var colorSlider3: UISlider!
    @IBOutlet weak var colorPreview: UIView!
    @IBOutlet weak var resetScore: UISwitch!
    @IBOutlet weak var howManyToWin: UIStepper!
    @IBOutlet weak var toWin: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func changeColor(_ sender: UISlider) {
        colorPreview.backgroundColor = UIColor(red: CGFloat(self.colorSlider.value), green: CGFloat(colorSlider2.value), blue: CGFloat(colorSlider3.value), alpha: 1.0)
        }
    @IBAction func changeColor2(_ sender: UISlider) {
        colorPreview.backgroundColor = UIColor(red: CGFloat(self.colorSlider.value), green: CGFloat(self.colorSlider2.value), blue: CGFloat(colorSlider3.value), alpha: 1.0)
    }
    @IBAction func changeColor3(_ sender: UISlider) {
        colorPreview.backgroundColor = UIColor(red: CGFloat(self.colorSlider.value), green: CGFloat(self.colorSlider2.value), blue: CGFloat(self.colorSlider3.value), alpha: 1.0)
    }

    @IBAction func scoreToWin(_ sender: UIStepper) {
        toWin.text = String(Int(howManyToWin.value))
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//    let backgroundPreview = colorPreview
//    backgroundPreview.view.backgroundColor = UIColor(red: CGFloat(self.colorSlider.value), green: CGFloat(self.colorSlider2.value), blue: CGFloat(self.colorSlider3.value), alpha: 1.0)
    
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let gvc = segue.destination as? GesturesViewController {
            gvc.correctColorValue = Double(colorSlider.value)
            gvc.correctColorValue2 = Double(colorSlider2.value)
            gvc.correctColorValue3 = Double(colorSlider3.value)
            gvc.scoreToWin = howManyToWin.value
            gvc.gameSwitch = resetScore.isOn
            if resetScore.isOn {
             gvc.resetScore = 0
            } else { gvc.resetScore += 1
        }
        }
    }
}
