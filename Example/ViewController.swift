//
//  ViewController.swift
//  CountryPicker
//
//  Created by Daniele Boscolo on 07/06/17.
//  Copyright © 2017 Daniele Boscolo. All rights reserved.
//

import UIKit
import CountryPicker
extension UIViewController {
    class func loadFromNib<T: UIViewController>() -> T {
        return T(nibName: String(describing: self), bundle: nil)
    }
}
class ViewController: UIViewController {

    @IBOutlet weak var countryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func showCountryPickerButtonTouchUpInside(_ sender: Any) {
        
        if let vc = CountryPickerViewController.loadFromNib() as? CountryPickerViewController {
            
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
}

extension ViewController: CountryPickerViewControllerDelegate {
    func countryPickerViewController(_ countryPickerViewController: CountryPickerViewController, didSelect country: Country) {
        countryLabel.text = "\(country.emoji) \(country.name) \n+\(country.phonePreffix ?? "")"
    }
}
