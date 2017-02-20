//
//  ViewController.swift
//  BigTipper
//
//  Created by Brian Watson on 2/8/17.
//  Copyright © 2017 bwats. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Core functionaliy labels
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    // Animation variables
    @IBOutlet weak var card1: UILabel!
    @IBOutlet weak var card2: UILabel!
    @IBOutlet weak var card3: UILabel!
    @IBOutlet weak var card4: UILabel!
    
    // Split functionality labels
    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var splitStepper: UIStepper!
    @IBOutlet weak var splitLabel: UILabel!
    
    // Global variables
    var numberOfPeopleToSplitWith = 0.0
    var globalTotalAmount = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Initialize variables
        numLabel.text = "1"
        splitLabel.text = "$0.00"
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        numberOfPeopleToSplitWith = 1
        
        self.billField.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        billField.center.x  -= view.bounds.width
        tipLabel.center.x -= view.bounds.width
        totalLabel.center.x -= view.bounds.width
        
        card1.center.x -= view.bounds.width
        card2.center.x -= view.bounds.width
        card3.center.x -= view.bounds.width
        card4.center.x -= view.bounds.width
        
        UIView.animate(withDuration: 1.0, delay: 0.5, options: [], animations: {
            self.card1.center.x += 1000
            self.card2.center.x += 1000
            self.card3.center.x += 1000
            self.card4.center.x += 1000
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5) {
            self.billField.center.x += self.view.bounds.width
            self.tipLabel.center.x += self.view.bounds.width
            self.totalLabel.center.x += self.view.bounds.width
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }

    // Tip function
    @IBAction func calculateTip(_ sender: AnyObject) {
        
        // Values of segmented index
        var tipPercentages = [0.18, 0.2, 0.22]
        let tipPercent = tipPercentages[tipControl.selectedSegmentIndex]
        
        // Set values
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercent
        let total = bill + tip
        globalTotalAmount = bill + tip
        
        // Number formatting set up
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        
        // Run through number format
        let tipAmount = numberFormatter.string(from: NSNumber(value: tip))
        let totalAmount = numberFormatter.string(from: NSNumber(value: total))
        let newSplitAmount = numberFormatter.string(from: NSNumber(value: total / numberOfPeopleToSplitWith))
        
        tipLabel.text = "$" + tipAmount!
        totalLabel.text = "$" + totalAmount!
        splitLabel.text = "$" + newSplitAmount!
        
        // Update the splitLabel
        
        // double check we have people to split with
        // if numberOfPeopleToSplitWith > 0 {}
        
    }
    
    // Stepper action
    @IBAction func stepAction(_ sender: UIStepper) {
        print("step on") // Test to make sure it works
        numLabel.text = String(Int(sender.value))
        
        // Remembering the number of people we are splitting with
        numberOfPeopleToSplitWith = sender.value
        print("Total amount to split: ", globalTotalAmount)
        
        let splitValue = globalTotalAmount / sender.value
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        
        let splitAmountFormatted = numberFormatter.string(from: NSNumber(value: splitValue))
        
        splitLabel.text = "$" + splitAmountFormatted!
    }
    
}

