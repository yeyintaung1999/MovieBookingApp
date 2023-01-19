//
//  GenreCollectionViewCell.swift
//  movieBookingApp
//
//  Created by Ye Yint Aung on 27/05/2022.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {
    
    
    
    @IBOutlet weak var genreName : UILabel!
    
    var genre : String?{
        didSet{
            if let genre = genre {
                genreName.text = genre
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //genreName.text = genre ?? "default"
    }

}
