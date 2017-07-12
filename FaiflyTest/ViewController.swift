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
    
    @IBOutlet weak var tableView: UITableView!
    
    var countries = [NSManagedObject]()
    var country = NSManagedObject()
    
    var countryAndCities = CountryAndCities(countryName: "", citiesList: [""])
    var countriesArray = [CountryAndCities]()
    
    var countriesFromJson = [String]()
    var sortedCountries = [String]()
    var tempCities = ["Paris","Marcelle"] //, ["Madrid", "Barcelona"]]
    
    var countriesFromCoreData = [String]()
    var citiesFromCoreData = [[String]]() //, ["Madrid", "Barcelona"]]
    
    var citiesDisplayedArray = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // json parsing
        let url = URL(string: "https://raw.githubusercontent.com/David-Haim/CountriesToCitiesJSON/master/countriesToCities.json")
        
        do {
            let data = try Data(contentsOf: url!)
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSDictionary//[String: Any]
            countriesFromJson = Array(json.allKeys) as! [String]
            sortedCountries = countriesFromJson.sorted()
            //print(sortedCountries)
            //print(sortedCountries.count)
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
//        var n = 1
//        for i in countriesArray {
//            let entity = NSEntityDescription.insertNewObject(forEntityName: "Country", into: context)
//            entity.setValue(i.countryName, forKey: "name")
//            entity.setValue(i.citiesList, forKey: "cities")
//            
//            do {
//                try context.save()
//                print("SAVED")
//                print(n)
//            } catch {
//                print("ERROR: \(error)")
//            }
//            n += 1
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
//                    print(resultData)
                    
                    
                    
                    // fetch data
                    if let countryName = (result as AnyObject).value(forKey: "name") as? String {
                        //print(countryName)
                        countriesFromCoreData.append(countryName)
                        
                    }
                    if let citiesList = (result as AnyObject).value(forKey: "cities") as? [String] {
                        print("EACH CITYLIST COUNT: \(citiesList.count)")
                        citiesFromCoreData.append(citiesList)
                        
                    }
                }

            }
        } catch {
            print("Error: \(error)")
        }
        print("COUNTRIES COUNT: \(countriesFromCoreData.count)")
        print("CITIES ARRAYS COUNT: \(citiesFromCoreData.count)")

    }


    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesDisplayedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let country = countries[indexPath.row]
        //let city = country.value(forKeyPath: "cities") as! [String]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = citiesDisplayedArray[indexPath.row]
        return cell
    }
    
//    func save(name: String) {
//        
//        guard let appDelegate =
//            UIApplication.shared.delegate as? AppDelegate else {
//                return
//        }
//        
//        // 1
//        let managedContext = appDelegate.persistentContainer.viewContext
//        
////        cityName = cities[indexPath.row]
////        
////        let cityAddingPercentEncoding = cityName.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)
//        
//        
//        
//        // 2
//        let entity =
//            NSEntityDescription.entity(forEntityName: "Country",
//                                       in: managedContext)!
//        
//        let country = NSManagedObject(entity: entity,
//                                     insertInto: managedContext)
//        
//        // 3
//        country.setValue(name, forKeyPath: "name")
//        
//        // 4
//        do {
//            try managedContext.save()
//            countries.append(country)
//        } catch let error as NSError {
//            print("Could not save. \(error), \(error.userInfo)")
//        }
//    }
    
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
        self.tableView.reloadData()
        
        //        self.denomination = Int(pickerData[row])!
//        print(self.denomination)
    }



}

