//
//  CardCollectionViewCell.swift
//  movieBookingApp
//
//  Created by Ye Yint Aung on 24/02/2022.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var last4Digit: UILabel!
    @IBOutlet weak var cardHolder: UILabel!
    @IBOutlet weak var expireDate: UILabel!
    
    var card : Card?{
        didSet{
            if let card = card {
                cardHolder.text = card.cardHolder
                expireDate.text=card.expirationDate
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
