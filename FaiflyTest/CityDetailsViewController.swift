//
//  CityDetailsr.swift
//  FaiflyTest
//
//  Created by Anna on 12.07.17.
//  Copyright © 2017 Anna. All rights reserved.
//

import UIKit
import MapKit

class CityDetailsViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var thumbnailImage: UIImageView!

    @IBOutlet weak var labelTrailingConstraint: NSLayoutConstraint!

    var cityName = String()
    
    var summary = String()
    var thumbnail: String?
    var latitude = Double()
    var longitude = Double()
    let annotation = MKPointAnnotation()
    
    let regionRadius: CLLocationDistance = 1000
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cityAddingPercentEncoding = cityName.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)
        
        let url = URL(string: "http://api.geonames.org/wikipediaSearchJSON?q=\(cityAddingPercentEncoding!)&maxRows=10&username=fat_cat")
        
        
        do {
            let data = try Data(contentsOf: url!)
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSDictionary
            //print(json)
            let geonames = json["geonames"] as! [[String:AnyObject]]
            var result = geonames.first!
            //print(result)
            summary = result["summary"] as! String
            thumbnail = result["thumbnailImg"] as? String
            latitude = result["lat"] as! Double
            longitude = result["lng"] as! Double


            
        }
        catch {
            print(error)
        }
        
        
        summaryLabel.text = summary
        if thumbnail != nil {
            thumbnailImage.image = stringToImage(string: thumbnail!)
        } else {
            labelTrailingConstraint.constant = 0
        }
        
        let initialLocation = CLLocation(latitude: latitude, longitude: longitude)
        centerMapOnLocation(location: initialLocation)
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        mapView.addAnnotation(annotation)
       
        
    }

    func stringToImage(string: String) -> UIImage {
        let imageUrl = URL(string: string)!
        let data = NSData(contentsOf: imageUrl)
        let image = UIImage(data:data! as Data)!
        
        return image
        
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    


    

       


}
