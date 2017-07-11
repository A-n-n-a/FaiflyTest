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
    
    var countries = [NSManagedObject]()
    var country = NSManagedObject()
    
    var tempCountries = ["France", "Spain"]
    var tempCities = ["Paris","Marcelle"] //, ["Madrid", "Barcelona"]]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
//        country.setValue("France", forKeyPath: "name")
//        country.setValue(["Paris", "Marcelle"], forKeyPath: "cities")  
        //save(name: "Ukraine")
        
        let url = URL(string: "https://raw.githubusercontent.com/David-Haim/CountriesToCitiesJSON/master/countriesToCities.json")
        
        do {
            let data = try Data(contentsOf: url!)
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSDictionary//[String: Any]
            tempCountries = Array(json.allKeys) as! [String]
            print(tempCountries)
//            let result = json[resultsString] as! [[String:AnyObject]]
//            
//            removeDataFromFirebase(isSearching: isSearching)
//            
//            for i in result {
//                
//                let singleRecipe = Recipe(dictionary: i)
//                
//                recipeArray.append(singleRecipe)
//                
//                let recipesItem = [
//                    titleString: singleRecipe.title,
//                    hrefString: singleRecipe.href,
//                    ingredientsString: singleRecipe.ingredients,
//                    thumbnailString: singleRecipe.recipeImage ?? " "
//                    ] as [String : Any]
//                
//                saveDataToFirebase(text: recipesItem, isSearching: isSearching)
            
            //}
        }
        catch {
            print(error)
        }

        
        //JSON Open Weather Map with SwiftyJSON
//        let session = URLSession.shared.dataTask(with: url!) { (data, response, error) in
//            
//            if error != nil {
//                print("Error: \(String(describing: error))")
//            } else {
//                
//                
//                
//                let json = JSON(data!)
//
//                print(json)
//                //                cityName = json[nameStr].stringValue
//                //
//                //                temp = json[mainStr][tempStr].double!
//                //                let celcTemp = kelvinToCelcius(kelvin: temp)
//                //                var tempString = emptyStr
//                //                if celcTemp > 0 {
//                //                    tempString = plusStr + String(celcTemp) + degreeStr
//                //                } else {
//                //                    tempString = String(celcTemp) + degreeStr
//                //                }
//                //                self.temperaturesArray.append(tempString)
//                //
//                //                latitude = json[coordStr][latStr].double!
//                //                self.latitudesArray.append(latitude)
//                //
//                //                longtitude = json[coordStr][lonStr].double!
//                //                self.longtitudesArray.append(longtitude)
//                //
//                //                description = json[weatherStr][0][descriptionStr].stringValue
//                //                self.descriptionsArray.append(description)
//                //
//                //                icon = json[weatherStr][0][iconStr].stringValue
//                //                //print("ICON: \(icon)")
//                //                let iconImage = stringIconToImage(strIcon: icon)
//                //                //print("ICON IMAGE: \(iconImage)")
//                //
//                //                self.weatherDetails = City(name: cityName, temp: tempString, desc: description, icon: iconImage, lon: longtitude, lat: latitude)
//                //                self.cityList.append(self.weatherDetails!)
//                //
//                //                // Display weather on the main thread
//                //                DispatchQueue.main.async {
//                //                    //city Name displays as it was input by user
//                //                    //cell.cityNameLabel?.text = self.cities[indexPath.row]
//                //                    //city name displays as it is in JSON
//                //                    print("INDEXPATH OUTPUT: \(indexPath.row)")
//                //                    if indexPath.row < self.cityList.count {
//                //                        cell.cityNameLabel?.text = self.cityList[indexPath.row].name
//                //                        cell.descriptionLabel?.text = self.cityList[indexPath.row].desc
//                //                        cell.temperatureLabel?.text = self.cityList[indexPath.row].temp
//                //                        cell.iconImageView?.image = self.cityList[indexPath.row].icon
//                // }
//                //}
//            }
//        }
//        session.resume()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let country = countries[indexPath.row]
        //let city = country.value(forKeyPath: "cities") as! [String]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = tempCities[indexPath.row]
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
        return tempCountries.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tempCountries[row] //.value(forKey: "name") as! String
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        self.denomination = Int(pickerData[row])!
//        print(self.denomination)
    }



}

