//
//  ShareSelectViewController.swift
//  ShareExtension
//
//  Created by Mohamed Sobhi  Fouda on 8/5/18.
//  Copyright © 2018 CareerFoundry. All rights reserved.
//

import UIKit

protocol ShareSelectViewControllerDelegate: class {
    func selected(list: String)
}

class ShareSelectViewController: UIViewController {
    
    var lists = ["Saved", "Default"]
    weak var delegate: ShareSelectViewControllerDelegate?

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.frame)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ShareCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        title = "Select Deck"
        view.addSubview(tableView)
    }
}

extension ShareSelectViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShareCell", for: indexPath)
        cell.textLabel?.text = lists[indexPath.row]
        cell.backgroundColor = .clear
        return cell
    }
}

extension ShareSelectViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: indexPath!)
        delegate?.selected(list: (currentCell?.textLabel?.text)!)
    }
}
