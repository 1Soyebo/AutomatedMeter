//
//  HistoryTableViewCell.swift
//  ObasProject
//
//  Created by Ibukunoluwa Soyebo on 18/08/2021.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblPower: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var viewCard: UIView!
    static let identifier = "HistoryTableViewCell"
    
    static func getNib() -> UINib{
        .init(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        viewCard.layer.borderColor = UIColor.black.withAlphaComponent(0.6).cgColor
        viewCard.layer.borderWidth = 0.8
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
