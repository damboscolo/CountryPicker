//
//  ViewController.swift
//  CountryPicker
//
//  Created by Daniele Boscolo on 07/06/17.
//  Copyright © 2017 Daniele Boscolo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var countryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? CountryPickerViewController {
            vc.delegate = self
        }
    }
}

extension ViewController: CountryPickerViewControllerDelegate {
    func countryPickerViewController(_ countryPickerViewController: CountryPickerViewController, didSelect country: Country) {
        countryLabel.text = "\(country.emoji) \(country.name) \n+\(country.phonePreffix ?? "")"
    }
}
