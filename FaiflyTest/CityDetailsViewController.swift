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
    
    var summary = String()
    var thumbnail: String?
    var latitude = Float()
    var longitude = Float()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cityAddingPercentEncoding = cityName.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)
        
        let url = URL(string: "http://api.geonames.org/wikipediaSearchJSON?q=\(cityAddingPercentEncoding!)&maxRows=10&username=fat_cat")
        print(url!)
        
        
        do {
            let data = try Data(contentsOf: url!)
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSDictionary
            //print(json)
            let geonames = json["geonames"] as! [[String:AnyObject]]
            var result = geonames.first!
            print(result)
            summary = result["summary"] as! String
            thumbnail = result["thumbnailImg"] as? String
            latitude = result["lat"] as! Float
            longitude = result["lng"] as! Float


            
        }
        catch {
            print(error)
        }
        
    }


    


}
