//
//  SettingsViewController.swift
//  tipper
//
//  Created by Beach, Doug on 3/5/17.
//  Copyright © 2017 Beach, Doug. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tipControl: UISegmentedControl!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaults = UserDefaults.standard
        let defaultTipIndex = defaults.integer(forKey: "another_key_that_you_choose")
        tipControl.selectedSegmentIndex = defaultTipIndex
    }
    
    @IBAction func setDefaultTipAmount(_ sender: AnyObject) {
        let defaults = UserDefaults.standard
        defaults.set(tipControl.selectedSegmentIndex, forKey: "another_key_that_you_choose")
        defaults.synchronize()
    }
}
