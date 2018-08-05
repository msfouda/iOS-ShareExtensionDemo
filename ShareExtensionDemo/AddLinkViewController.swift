//
//  AddLinkViewController.swift
//  ShareExtensionDemo
//
//  Created by Mohamed Sobhi  Fouda on 8/5/18.
//  Copyright © 2018 CareerFoundry. All rights reserved.
//

import UIKit

class AddLinkViewController: UITableViewController {
    let userDefaultsKey = "SavedLinksUserDefaultsKey"
    
    var linkList = ["https://google.com", "https://facebook.com", "https://careerfoundry.com", "https://github.com", "https://stackoverflow.com"]
    
    var links: Array<String> {
        get {
            let userDefaults = UserDefaults(suiteName: "group.com.mr-sobhi.ShareExtensionDemo")
            if let links = userDefaults?.object(forKey: userDefaultsKey) as! Array<String>? {
                return links
            }
            
            return []
        }
        set {
            let userDefaults = UserDefaults(suiteName: "group.com.mr-sobhi.ShareExtensionDemo")
            userDefaults?.set(newValue, forKey: userDefaultsKey)
            userDefaults?.synchronize()
        }
    }
    
    var savedLinks: Array<String> {
        get {
            let userDefaults = UserDefaults(suiteName: "group.com.mr-sobhi.ShareExtensionDemo")
            if let links = userDefaults?.object(forKey: "LinksUserDefaultsKey") as! Array<String>? {
                return links
            }
            
            return []
        }
        set {
            let userDefaults = UserDefaults(suiteName: "group.com.mr-sobhi.ShareExtensionDemo")
            userDefaults?.set(newValue, forKey: "LinksUserDefaultsKey")
            userDefaults?.synchronize()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        linkList += links
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return linkList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = linkList[(indexPath as NSIndexPath).row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: indexPath!)
        if let link = currentCell?.textLabel?.text {
            self.savedLinks.append(link)
            navigationController?.popViewController(animated: true)
        }
    }

}
