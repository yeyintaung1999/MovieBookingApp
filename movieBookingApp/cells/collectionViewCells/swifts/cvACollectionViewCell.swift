//
//  cvACollectionViewCell.swift
//  movieBookingApp
//
//  Created by Ye Yint Aung on 23/02/2022.
//

import UIKit

class cvACollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var weekDay: UILabel!
    @IBOutlet weak var dayText: UILabel!
    
    var date: dateVO?{
        didSet {
            if let date = date {
                
                if date.isSelected {
                    self.dayText.textColor = UIColor.white
                    self.weekDay.textColor = UIColor.white
                } else {
                    self.dayText.textColor = UIColor.lightGray
                    self.weekDay.textColor = UIColor.lightGray
                }
                
                let dateformatter = DateFormatter()
                dateformatter.locale = Locale(identifier: "en")
                dateformatter.dateFormat = "yyyy-MM-dd"
                
                let day = dateformatter.string(from: date.date).split(separator: "-")[2]
                if day.count > 1 {
                    dayText.text = "\(day)"
                } else {
                    dayText.text = "0\(day)"
                }
                
                let condition = Calendar.current.component(.weekday, from: date.date)
                switch condition {
                case 1:
                    weekDay.text = "SUN"
                case 2:
                    weekDay.text = "MON"
                case 3:
                    weekDay.text = "TUE"
                case 4:
                    weekDay.text = "WED"
                case 5:
                    weekDay.text = "THU"
                case 6:
                    weekDay.text = "FRI"
                case 7:
                    weekDay.text = "SAT"
                default:
                    weekDay.text = "error"
                }
            }
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }
    
    

}
