//
//  SettingsViewController.swift
//  AC3.2-GesturesAndControls
//
//  Created by Ana Ma on 9/29/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var colorSlider: UISlider!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let gvc = segue.destination as? GesturesViewController{
            gvc.correctColorValue = Double(colorSlider.value)
        }
    }
    

}
