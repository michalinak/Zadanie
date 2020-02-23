//
//  MasterTableViewCell.swift
//  Zadanie1
//
//  Created by Michalina Kukielko on 22/02/2020.
//  Copyright © 2020 Michalina Kukielko. All rights reserved.
//

import UIKit
import SDWebImage

class MasterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var numberImageView: UIImageView!
    @IBOutlet weak var numberNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selected ? configureAppearance(mode: .selected) : configureAppearance(mode: .defaultMode)
    }
    
    func configure(number: NumberModel) {
        numberNameLabel.text = number.name
        numberImageView.sd_setImage(with: URL(string: number.image))
        configureAppearance(mode: .defaultMode)
    }
    
    func configureAppearance(mode: CellMode) {
        switch mode {
        case .selected:
            numberNameLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        case .highlighted:
            numberNameLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            backgroundColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
        case .defaultMode:
            numberNameLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            backgroundColor = .clear
        }
    }
}
