//
//  CityDetailsr.swift
//  FaiflyTest
//
//  Created by Anna on 12.07.17.
//  Copyright © 2017 Anna. All rights reserved.
//

import UIKit

class CityDetailsViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    var cityName = String()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cityAddingPercentEncoding = cityName.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)
        
        let url = URL(string: "http://api.geonames.org/wikipediaSearch?q=london&maxRows=10&username=demo")
        //let url = URL(string: "http://api.geonames.org/wikipediaSearch?q=\(cityAddingPercentEncoding!)&maxRows=10&username=demo")
        //"http://api.openweathermap.org/data/2.5/weather?q=\(cityAddingPercentEncoding!)&APPID=c50391d958cdbde9e137158a91a1c8e3")
        
        let request = URLRequest(url: url!)
        webView.loadRequest(request)
//        do {
//            let data = try Data(contentsOf: url!)
//            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSDictionary
//            print(json)
////            countriesFromJson = Array(json.allKeys) as! [String]
////            sortedCountries = countriesFromJson.sorted()
////            let dictionary = json as! [String:AnyObject]
////            
////            for i in sortedCountries {
////                countryAndCities =  CountryAndCities(countryName: i, citiesList: dictionary[i] as! [String])
////                countriesArray.append(countryAndCities)
////            }
//            
//        }
//        catch {
//            print(error)
//        }



        //JSON Open Weather Map with SwiftyJSON
//        let session = URLSession.shared.dataTask(with: url!) { (data, response, error) in
//            
//            if error != nil {
//                print("Error: \(String(describing: error))")
//            } else {


        
    }


    


}
