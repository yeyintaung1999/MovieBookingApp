//
//  CastCollectionViewCell.swift
//  movieBookingApp
//
//  Created by Ye Yint Aung on 21/02/2022.
//

import UIKit

class CastCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    
    var data : Cast? {
        didSet{
            if let data = data {
                let profilePath = "\(imageBaseUrl)\(data.profilePath ?? "")"
                image.sd_setImage(with: URL(string: profilePath))
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
