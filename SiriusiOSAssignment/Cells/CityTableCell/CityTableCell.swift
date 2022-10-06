//
//  CityTableCell.swift
//  SiriusiOSAssignment
//
//  Created by Nay Oo Linn on 06/10/2022.
//

import UIKit

class CityTableCell: UITableViewCell {
    
    // MARK: Outlets
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblCoord: UILabel!

    // MARK: Setup
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    // MARK: Update
    func setData(_ data: CityData) {
        lblCity.text = "\(data.name ?? ""), \(data.country ?? "")"
        lblCoord.text = "\(data.coord?.latDMS ?? "") | \(data.coord?.lonDMS ?? "")"
    }
}
