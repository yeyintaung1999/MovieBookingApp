//
//  ComboTableViewCell.swift
//  movieBookingApp
//
//  Created by Ye Yint Aung on 21/02/2022.
//

import UIKit

class ComboTableViewCell: UITableViewCell {
    
    @IBOutlet weak var snackName : UILabel!
    @IBOutlet weak var snackDetail : UILabel!
    @IBOutlet weak var snackPrice : UILabel!
    
    @IBOutlet weak var firstCountButton: UIButton!
    var onTap : ((Int,Int,Int)->Void) = { _,_,_ in}
    var count = 0
    var amount = 0
    var price : Int = 0
    var id: Int = 0
    var data : Snack? {
        didSet{
            if let data = data {
                id = data.id ?? 0
                price=data.price ?? 0
                snackName.text = data.name
                snackDetail.text = data.datumDescription
                snackPrice.text = "\(data.price ?? 0) $"
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func decreaseButton(_ sender: UIButton) {
        if count > 0 {
            count-=1
            firstCountButton.titleLabel?.text = "\(count)"
            onTap(count,price,id)
        }
    }
    
    @IBAction func increaseButton(_ sender: UIButton) {
        count+=1
        firstCountButton.titleLabel?.text = "\(count)"
        onTap(count,price,id)
    }
}
