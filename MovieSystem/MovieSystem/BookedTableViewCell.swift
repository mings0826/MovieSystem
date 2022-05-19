//
//  BookedTableViewCell.swift
//  MovieSystem
//
//  Created by 滕富山 on 2022/5/11.
//

import UIKit

class BookedTableViewCell: UITableViewCell {

    @IBOutlet weak var zwLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
