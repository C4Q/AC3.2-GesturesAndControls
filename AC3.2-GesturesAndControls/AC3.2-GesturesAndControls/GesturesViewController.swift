//
//  ViewController.swift
//  AC3.2-GesturesAndControls
//
//  Created by Madushani Lekam Wasam Liyanage on 9/30/16.
//  Copyright © 2016 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import UIKit

class GesturesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tapGesture.require(toFail: doubleTapGesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet var tapGesture: UITapGestureRecognizer!
    @IBOutlet var rightSwipeGesture: UISwipeGestureRecognizer!
    @IBOutlet var leftSwipeGesture: UISwipeGestureRecognizer!
    @IBOutlet var doubleTapGesture: UITapGestureRecognizer!
    @IBOutlet var twoFingerTouchGesture: UITapGestureRecognizer!
    
    @IBAction func gestureTapped(_ sender: UITapGestureRecognizer) {
        print("I was tapped")
    }
    @IBAction func swipedRight(_ sender: UISwipeGestureRecognizer) {
        print("Swiped Right")
    }
    @IBAction func swipedLeft(_ sender: UISwipeGestureRecognizer) {
        print("Swiped Left")
    }
    @IBAction func doubleTapped(_ sender: UITapGestureRecognizer) {
        print("Double Tapped")
    }
    @IBAction func twoFingersTouched(_ sender: UITapGestureRecognizer) {
        print("Two Fingers Touched")
    }
    
}

