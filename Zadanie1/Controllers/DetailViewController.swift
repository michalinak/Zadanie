//
//  DetailViewController.swift
//  Zadanie1
//
//  Created by Michalina Kukielko on 22/02/2020.
//  Copyright © 2020 Michalina Kukielko. All rights reserved.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    @IBOutlet weak var numberImage: UIImageView!
    @IBOutlet weak var numberTextLabel: UILabel!
    
    private let networkManager = NetworkManager()
    
    var number: NumberModel? {
        didSet {
            DispatchQueue.main.async {
                self.setupUI()
            }
        }
    }
    
    // MARK: - Application lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDefaultNumber()
    }
    
    // MARK: - Private functions
    
    private func setupUI() {
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
        
        numberTextLabel.text = number?.text
        guard let image = number?.image else { return }
        numberImage.sd_setImage(with: URL(string: image))
    }
    
    private func getDefaultNumber() {
        networkManager.getNumbers() { [weak self] numbersList in
            guard let numbersList = numbersList else { return }
            self?.downloadNumberDetails(name: numbersList[0].name)
        }
    }
    
    private func downloadNumberDetails(name: String) {
        networkManager.getNumberDetail(queryValue: name) { [weak self] numberDetail in
            guard let numberDeatil = numberDetail else { return }
            self?.number = numberDeatil
        }
    }
}

extension DetailViewController: MasterTableViewControllerDelegate {
    func numberSelected(name: String) {
        downloadNumberDetails(name: name)
    }
}
