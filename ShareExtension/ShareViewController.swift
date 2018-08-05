//
//  ShareViewController.swift
//  ShareExtension
//
//  Created by Mohamed Sobhi  Fouda on 8/5/18.
//  Copyright © 2018 CareerFoundry. All rights reserved.
//

import UIKit
import Social
import MobileCoreServices

class ShareViewController: SLComposeServiceViewController {
    let userDefaultsKey = "LinksUserDefaultsKey"
    var selectedList = "Saved"
    
    var links: Array<String> {
        get {
            let userDefaults = UserDefaults(suiteName: "group.com.mr-sobhi.ShareExtensionDemo")
            if let links = userDefaults?.object(forKey:userDefaultsKey) as! Array<String>? {
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
            if let links = userDefaults?.object(forKey: "SavedLinksUserDefaultsKey") as! Array<String>? {
                return links
            }
            
            return []
        }
        set {
            let userDefaults = UserDefaults(suiteName: "group.com.mr-sobhi.ShareExtensionDemo")
            userDefaults?.set(newValue, forKey: "SavedLinksUserDefaultsKey")
            userDefaults?.synchronize()
        }
    }

    override func didSelectPost() {
        let contentType = kUTTypeURL as String
        let content = extensionContext!.inputItems.first as! NSExtensionItem
        
        print("Did select post")
        
        if let attachment = content.attachments?.first {
            if (attachment as AnyObject).hasItemConformingToTypeIdentifier(contentType) {
                (attachment as AnyObject).loadItem(forTypeIdentifier: contentType, options: nil, completionHandler: { (data, error) in
                    guard error == nil else {
                        print(error)
                        return
                    }
                    print("attempting to save url")
                    
                    let url = data as! NSURL
                    if self.selectedList == "Saved" {
                        self.links.append(url.absoluteString!)
                        print("links appended")
                        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
                    } else {
                        self.savedLinks.append(url.absoluteString!)
                        print("saved links appended")
                        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
                    }
                })
            }
        }
    }
    
    override func configurationItems() -> [Any]! {
        let item = SLComposeSheetConfigurationItem()
        item?.title = "Selected List"
        item?.value = selectedList
        
        item?.tapHandler = {
            let vc = ShareSelectViewController()
            vc.delegate = self
            self.pushConfigurationViewController(vc)
        }
        
        return [item!]
    }

}

extension ShareViewController: ShareSelectViewControllerDelegate {
    func selected(list: String) {
        selectedList = list
        reloadConfigurationItems()
        popConfigurationViewController()
    }
}
