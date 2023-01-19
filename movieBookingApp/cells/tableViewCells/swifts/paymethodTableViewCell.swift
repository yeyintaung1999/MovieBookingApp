//
//  paymethodTableViewCell.swift
//  movieBookingApp
//
//  Created by Ye Yint Aung on 22/02/2022.
//

import UIKit

class paymethodTableViewCell: UITableViewCell {
    
    @IBOutlet weak var methodName : UILabel!
    @IBOutlet weak var methodDetail : UILabel!
    
    @IBOutlet weak var backView : UIView!
    
    var data : PayMethodVO?{
        didSet{
            if let data = data {
                methodName.text = data.method.name
                methodDetail.text = data.method.datumDescription
                if data.isSelected {
                    backView.backgroundColor = UIColor(named: "primaryColor")
                    
                }else {
                    backView.backgroundColor = UIColor.white
                }
            }
        }
    }
    
    var onTapFunc : ((Int)->Void) = { _ in }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        backView.isUserInteractionEnabled = true
        let tapGest = UITapGestureRecognizer(target: self, action: #selector(onTap))
        backView.addGestureRecognizer(tapGest)
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func onTap(){
        onTapFunc(data?.method.id ?? 0)
    }
    
}
