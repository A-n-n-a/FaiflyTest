//
//  ViewController.swift
//  FaiflyTest
//
//  Created by Anna on 11.07.17.
//  Copyright © 2017 Anna. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var countries = [NSManagedObject]()
    var country = NSManagedObject()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let country = countries[indexPath.row]
        let city = country.value(forKeyPath: "cities") as! [String]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = city[indexPath.row]
        return cell
    }
    
    func save(name: String) {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "Country",
                                       in: managedContext)!
        
        let country = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        // 3
        country.setValue(name, forKeyPath: "name")
        
        // 4
        do {
            try managedContext.save()
            countries.append(country)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }


}

