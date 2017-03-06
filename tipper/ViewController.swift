//
//  ViewController.swift
//  tipper
//
//  Created by Beach, Doug on 3/5/17.
//  Copyright © 2017 Beach, Doug. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var totalSplitLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var splitterCount: UITextField!
    @IBOutlet weak var splitterIncrementer: UIStepper!
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = UserDefaults.standard
        let defaultTipIndex = defaults.integer(forKey: "another_key_that_you_choose")
        tipControl.selectedSegmentIndex = defaultTipIndex
        
        calcTip(self)
    }

    override func viewDidAppear(_ animated: Bool) {
        // Show keyboard by default
        billField.becomeFirstResponder()
    }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func calcTip(_ sender: AnyObject) {
        let tipPercentages = [0.18,0.2,0.25]
        let bill = Double(billField.text!) ?? 00
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let waysSplit = Int(splitterCount.text!) ?? 1
        let total = bill + tip
        let totalSplit = total / Double(waysSplit)
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        totalSplitLabel.text = String(format: "$%.2f", totalSplit)
    }
    
    @IBAction func splitterCountChanged(_ sender: AnyObject) {
        inputValidation()
        splitterIncrementer.value = Double(splitterCount.text!) ?? 1
        
        calcTip(self)
    }
    
    func inputValidation(){
        // bounding total ways split to stepper bounds
        if Int(splitterCount.text!)! < Int(splitterIncrementer.minimumValue) {
            splitterCount.text = String(format: "%.0f",splitterIncrementer.minimumValue)
        } else if Int(splitterCount.text!)! > Int(splitterIncrementer.maximumValue) {
            splitterCount.text = String(format: "%.0f",splitterIncrementer.maximumValue)
        }
    }
    
    @IBAction func incrementSplitter(_ sender: Any) {
        splitterCount.text = String(format: "%.0f",splitterIncrementer.value)
        calcTip(self)
    }
}

