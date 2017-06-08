//
//  CountryPickerViewController.swift
//  CountryPicker
//
//  Created by Daniele Boscolo on 07/06/17.
//  Copyright © 2017 Daniele Boscolo. All rights reserved.
//

import UIKit

public protocol CountryPickerViewControllerDelegate: class {
    func countryPickerViewController(_ countryPickerViewController: CountryPickerViewController, didSelect country: Country)
}

public class CountryPickerViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    public weak var delegate: CountryPickerViewControllerDelegate?
    
    var allCountries: [Country] = []
    var countries: [Country] = []
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        let locale = Locale.current
        
        for code in Locale.isoRegionCodes {
            if let name = locale.localizedString(forRegionCode: code) {
                let country = Country(code: code, name: name, emoji: emojiFlag(code))
                if let _ = country.phonePreffix {
                    countries.append(country)
                }
            }
        }
        
        allCountries = countries.sorted { $0.name < $1.name }
        countries = allCountries
        
        tableView.reloadData()
    }
    
    func emojiFlag(_ countryCode: String) -> String {
        var string = ""
        var country = countryCode.uppercased()
        for uS in country.unicodeScalars {
            if let emoji = UnicodeScalar(127397 + uS.value) {
                string.append("\(emoji)")
            }
        }
        return string
    }
}

extension CountryPickerViewController: UITableViewDataSource, UITableViewDelegate {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "countryCellIdentifier") as? CountryTableViewCell {
            let country = countries[indexPath.row]
            cell.titleLabel.text = "\(country.emoji) \(country.name)"
            cell.detailLabel.text = "+\(country.phonePreffix ?? "")"
            return cell
        }
        return UITableViewCell()
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = countries[indexPath.row]
        delegate?.countryPickerViewController(self, didSelect: country)
        navigationController?.popViewController(animated: true)
    }
}

extension CountryPickerViewController: UISearchBarDelegate {
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            countries = allCountries
        } else {
            countries = allCountries.filter({ (country) -> Bool in
                return country.name.contains(searchText) || country.code.contains(searchText)
            })
        }
        tableView.reloadData()
    }
}
