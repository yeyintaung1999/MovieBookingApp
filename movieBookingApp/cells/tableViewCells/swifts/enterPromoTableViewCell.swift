//
//  enterPromoTableViewCell.swift
//  movieBookingApp
//
//  Created by Ye Yint Aung on 22/02/2022.
//

import UIKit

class enterPromoTableViewCell: UITableViewCell {

    @IBOutlet weak var promoTF: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let bottomline = CALayer()
        bottomline.backgroundColor = UIColor(named: "availableColor")?.cgColor
        bottomline.frame = CGRect(x: 0, y: promoTF.frame.height, width: promoTF.frame.width, height: 1)
        promoTF.borderStyle = UITextField.BorderStyle.none
        promoTF.layer.addSublayer(bottomline)
        
        promoTF.attributedPlaceholder = NSAttributedString(string: "Enter promo code", attributes: [NSAttributedString.Key.font:UIFont.italicSystemFont(ofSize: 18)])
        
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
