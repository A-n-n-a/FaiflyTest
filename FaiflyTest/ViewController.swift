//
//  ViewController.swift
//  FaiflyTest
//
//  Created by Anna on 11.07.17.
//  Copyright © 2017 Anna. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var tableView: UITableView!
    
    var countries = [NSManagedObject]()
    var country = NSManagedObject()
    
    var countryAndCities = CountryAndCities(countryName: "", citiesList: [""])
    var countriesArray = [CountryAndCities]()
    
    var countriesFromJson = [String]()
    var sortedCountries = [String]()
    
    var countriesFromCoreData = [String]()
    var citiesFromCoreData = [[String]]()
    
    var citiesDisplayedArray = [String]()
    var currentCitiesArray = [String]()
    
    var selectedRow = UITableViewCell()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        // json parsing
        let url = URL(string: "https://raw.githubusercontent.com/David-Haim/CountriesToCitiesJSON/master/countriesToCities.json")
        
        do {
            let data = try Data(contentsOf: url!)
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSDictionary
            countriesFromJson = Array(json.allKeys) as! [String]
            sortedCountries = countriesFromJson.sorted()
            let dictionary = json as! [String:AnyObject]
            
            for i in sortedCountries {
                countryAndCities =  CountryAndCities(countryName: i, citiesList: dictionary[i] as! [String])
                countriesArray.append(countryAndCities)
            }
            
        }
        catch {
            print(error)
        }

        
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        let context = appDelegate.persistentContainer.viewContext

        // save data to Core Data

//        for i in countriesArray {
//            let entity = NSEntityDescription.insertNewObject(forEntityName: "Country", into: context)
//            entity.setValue(i.countryName, forKey: "name")
//            entity.setValue(i.citiesList, forKey: "cities")
//            
//            do {
//                try context.save()
//                print("SAVED")

//            } catch {
//                print("ERROR: \(error)")
//            }
//        }
        
        
        
        // getting data from core data
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Country")
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            if results.count > 0 {
                for result in results {
                    
                    
                    
                    // delete all data from core data if needed
                    
                    
//                    let resultData = result as! NSManagedObject
//                    context.delete(resultData)
//                    try context.save()
//
                    
                    
                    // fetch data
                    if let countryName = (result as AnyObject).value(forKey: "name") as? String {
                        
                        countriesFromCoreData.append(countryName)
                        
                    }
                    if let citiesList = (result as AnyObject).value(forKey: "cities") as? [String] {
                        
                        citiesFromCoreData.append(citiesList)
                        
                    }
                }

            }
        } catch {
            print("Error: \(error)")
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
       
            pickerView.selectRow(0, inComponent: 0, animated: true)
            citiesDisplayedArray = citiesFromCoreData[0]
      

    }
    
    // TEBLE VIEW
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesDisplayedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = citiesDisplayedArray[indexPath.row]
        return cell
    }
    
    // PICKER
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countriesFromCoreData.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countriesFromCoreData[row] //.value(forKey: "name") as! String
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        citiesDisplayedArray = citiesFromCoreData[row]
        currentCitiesArray = citiesFromCoreData[row]
        self.tableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destViewController = segue.destination as! CityDetailsViewController
        
        let selectedRowIndex = self.tableView.indexPathForSelectedRow
        selectedRow = self.tableView.cellForRow(at: selectedRowIndex!)!
        
        destViewController.cityName = citiesDisplayedArray[(selectedRowIndex?.row)!]
    }



}

