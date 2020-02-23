//
//  MasterTableViewController.swift
//  Zadanie1
//
//  Created by Michalina Kukielko on 22/02/2020.
//  Copyright © 2020 Michalina Kukielko. All rights reserved.
//

import UIKit

protocol MasterTableViewControllerDelegate: class {
    func numberSelected(name: String)
}

class MasterTableViewController: UITableViewController {
    
    private let networkManager = NetworkManager()
    var numbers = [NumberModel]()
    weak var delegate: MasterTableViewControllerDelegate?
    
    
    // MARK: - Application lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getNumbersList()
    }
    
    // MARK: - Private functions
    
    private func getNumbersList() {
        networkManager.getNumbers() { [weak self] numbersList in
            guard let numbersList = numbersList else { return }
            self?.numbers = numbersList
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numbers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MasterCell", for: indexPath) as! MasterTableViewCell
        cell.configure(number: numbers[indexPath.row])
        
        if indexPath.row == 0 {
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.numberSelected(name: numbers[indexPath.row].name)
        
        if let detailViewController = delegate as? DetailViewController, let detailNavigationController = detailViewController.navigationController {
            splitViewController?
                .showDetailViewController(detailNavigationController, sender: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? MasterTableViewCell {
            cell.configureAppearance(mode: .highlighted)
        }
    }
    
    override func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? MasterTableViewCell {
            cell.configureAppearance(mode: .defaultMode)
        }
    }
}
