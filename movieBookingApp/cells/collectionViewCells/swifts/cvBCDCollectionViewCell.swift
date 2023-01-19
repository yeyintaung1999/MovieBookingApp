//
//  cvBCDCollectionViewCell.swift
//  movieBookingApp
//
//  Created by Ye Yint Aung on 23/02/2022.
//

import UIKit

class cvBCDCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cinema: UILabel!
    @IBOutlet weak var backView: UIView!
    
    var data : cinemaType? {
        didSet{
            if let data = data {
                cinema.text = data.name
                if data.isSelected {
                    backView.backgroundColor = UIColor(named: "primaryColor")
                    
                } else {
                    
                    backView.backgroundColor = UIColor.white
                    
                }
            }
        }
    }
    
    var onTapFunc : ((String)->Void) = {_ in}

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.isUserInteractionEnabled = true
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(onTap))
        backView.addGestureRecognizer(tapgesture)
    }
    
    @objc func onTap(){
        onTapFunc(data?.name ?? "")
    }

}
