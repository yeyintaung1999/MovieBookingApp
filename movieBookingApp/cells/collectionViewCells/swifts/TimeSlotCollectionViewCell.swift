//
//  TimeSlotCollectionViewCell.swift
//  movieBookingApp
//
//  Created by Ye Yint Aung on 03/05/2022.
//

import UIKit

class TimeSlotCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backGroundView: UIView!
    
    @IBOutlet weak var timeText : UILabel!

    var timeslotData : TimeSlotVO?{
        didSet{
            if let data = timeslotData {
                timeText.text = data.timeSlot.startTime
                if data.isSelect {
                    backGroundView.backgroundColor = UIColor(named: "primaryColor")
                } else {
                    backGroundView.backgroundColor = UIColor.white
                }
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(onTap))
        backGroundView.isUserInteractionEnabled = true
        backGroundView.addGestureRecognizer(tapgesture)
        
    }
    
    var onTapTimeSlot : ((Int,String)->Void) = { _,_ in}
    
    @objc func onTap(){
        onTapTimeSlot(timeslotData?.cinemaID ?? -1, timeslotData?.timeSlot.startTime ?? "00:00 AM/PM")
    }

}
