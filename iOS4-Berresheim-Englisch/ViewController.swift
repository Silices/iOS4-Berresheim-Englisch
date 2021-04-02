//
//  ViewController.swift
//  iOS4-Berresheim-Englisch
//
//  Created by Kenneth Englisch on 25.11.20.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var dollarRate: UITextField!
    @IBOutlet weak var poundRate: UITextField!
    
    @IBOutlet weak var euroValue: UITextField!
    @IBOutlet weak var dollarValue: UITextField!
    @IBOutlet weak var poundValue: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        euroValue.text! = "1.00"
        dollarValue.text! = "1.18"
        poundValue.text! = "0.89"
    }

    @IBAction func dollarRateChanged(_ sender: UITextField) {
        let euro = Double(euroValue.text!)!
        
        let dollar = euro * Double(dollarRate.text!)!
        dollarValue.text = String(format: "%.2lf", dollar)
    }
    
    @IBAction func poundRateChanged(_ sender: UITextField) {
        let euro = Double(euroValue.text!)!
        
        let pound = euro * Double(poundRate.text ?? "0.00")!
        poundValue.text = String(format: "%.2lf", pound)
    }
    
    @IBAction func euroValueChanged(_ sender: UITextField) {
        let euro = Double(sender.text!)!
                
        let dollar = euro * Double(dollarRate.text!)!
                
        let pound = euro * Double(poundRate.text ?? "0.00")!
                
        euroValue.text = String(format: "%.2lf", euro)
        dollarValue.text = String(format: "%.2lf", dollar)
        poundValue.text = String(format: "%.2lf", pound)
    }
    
    @IBAction func dollarValueChanged(_ sender: UITextField) {
        let dollar = Double(sender.text!)!
                
        let euro = dollar / Double(dollarRate.text!)!
                
        let pound = euro * Double(poundRate.text ?? "0.00")!
                
        euroValue.text = String(format: "%.2lf", euro)
        dollarValue.text = String(format: "%.2lf", dollar)
        poundValue.text = String(format: "%.2lf", pound)
    }
    
    @IBAction func poundValueChanged(_ sender: UITextField) {
        let pound = Double(sender.text!)!
                
        let euro = pound / Double(poundRate.text!)!
                
        let dollar = euro * Double(dollarRate.text!)!
                
        euroValue.text = String(format: "%.2lf", euro)
        dollarValue.text = String(format: "%.2lf", dollar)
        poundValue.text = String(format: "%.2lf", pound)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    @IBAction func buttonTaped(_ sender: UIButton) {
        let url = URL(string: "https://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml")!
            
        if let website = try? String(contentsOf: url, encoding: .utf8){
            let usdRate = website.range(of: "\"USD\" rate=\"")
            let gbpRate = website.range(of: "\"GBP\" rate=\"")
            
            guard let usdStartIndex = usdRate?.upperBound else {
                return
            }
            let usdEndIndex = website.index(usdStartIndex, offsetBy: 10)
        
            var substring = website[usdStartIndex..<usdEndIndex]
            guard let usdNewEndIndex = substring.range(of: "\"")?.lowerBound else {return}
            
            dollarRate.text = String(website[usdStartIndex..<usdNewEndIndex])
            
            guard let gbpStartIndex = gbpRate?.upperBound else {
                return
            }
            let gbpEndIndex = website.index(gbpStartIndex, offsetBy: 10)
            
            substring = website[gbpStartIndex..<gbpEndIndex]
            guard let gbpNewEndIndex = substring.range(of: "\"")?.lowerBound else {return}
            
            poundRate.text = String(website[gbpStartIndex..<gbpNewEndIndex])
            
            let euro = Double(euroValue.text!)!
            
            let dollar = euro * Double(dollarRate.text!)!
            dollarValue.text = String(format: "%.2lf", dollar)
            
            let pound = euro * Double(poundRate.text ?? "0.00")!
            poundValue.text = String(format: "%.2lf", pound)
        }
        
    }
    
}

 
