//
//  movieSliderCollectionViewCell.swift
//  movieBookingApp
//
//  Created by Ye Yint Aung on 23/02/2022.
//

import UIKit
import SDWebImage

class movieSliderCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backdropImage: UIImageView!
    
    @IBOutlet weak var genreTime: UILabel!
    @IBOutlet weak var movieName: UILabel!
    var data : MovieStruct? {
        didSet{
            if let data = data {
                let imagepath = data.posterPath ?? ""
                let posterpath = "\(imageBaseUrl)\(imagepath)"
                movieName.text = data.originalTitle
                genreTime.text = data.genres?.joined(separator: "/")
                backdropImage.sd_setImage(with: URL(string: posterpath))
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    

}
