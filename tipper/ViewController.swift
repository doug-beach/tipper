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
    var lastSplitValue = 1
    

    override func viewDidLoad() {
        splitterCount.tag = 1
        splitterIncrementer.tag = 2
        
    }
    
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
        updateSplitterFields(sender)
        let tipPercentages = [0.1,0.18,0.2,0.25]
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let waysSplit = Int(splitterCount.text!) ?? 1
        let total = bill + tip
        let totalSplit = total / Double(waysSplit)
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        totalSplitLabel.text = String(format: "$%.2f", totalSplit)
    }
    
    func updateSplitterFields(_ sender: AnyObject){
        if let value = sender.tag {
            switch value {
                case 1:
                    splitterCountChanged(sender)
                case 2:
                    incrementSplitter(sender)
                default: break
            }
        }
    }
    func splitterCountChanged(_ sender: AnyObject) {
        splitterCountValidation()
        // keep incrementer in sync with display
        splitterIncrementer.value = Double(splitterCount.text!) ?? 1
        
    }
    
    func splitterCountValidation(){
        // bounding total ways split to stepper bounds and only parsable ints
        lastSplitValue = Int(splitterCount.text!) ?? lastSplitValue
        if splitterCount.text == nil || splitterCount.text! == ""  {
            return
        }
        if lastSplitValue < Int(splitterIncrementer.minimumValue) {
            splitterCount.text = String(format: "%.0f",splitterIncrementer.minimumValue)
        } else if lastSplitValue > Int(splitterIncrementer.maximumValue) {
            splitterCount.text = String(format: "%.0f",splitterIncrementer.maximumValue)
        } else {
            splitterCount.text = String(lastSplitValue)
        }
        
    }
    
    func incrementSplitter(_ sender: Any) {
        //update the display in sync with incrementer
        splitterCount.text = String(format: "%.0f",splitterIncrementer.value)
    }
}

