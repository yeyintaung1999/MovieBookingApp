//
//  payBtnTableViewCell.swift
//  movieBookingApp
//
//  Created by Ye Yint Aung on 22/02/2022.
//

import UIKit

class payBtnTableViewCell: UITableViewCell {
    
    var delegate : PayButtonDelegate?=nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func payBtn(_ sender: UIButton) {
        delegate?.onTapPayButton()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
