//
//  SeatCollectionViewCell.swift
//  movieBookingApp
//
//  Created by Ye Yint Aung on 24/02/2022.
//

import UIKit

class SeatCollectionViewCell: UICollectionViewCell {
    
    var seatDetail : SeatVO? {
        didSet{
            if let data = seatDetail {
                bindSeatArray(seat: data)
            }
        }
    }
    
    var onTapFunc : ((String,Int)->Void) = { _,_ in}
    
    @IBOutlet weak var seatView: UIView!
    
    @IBOutlet weak var seatLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @objc func onTapSeat(){
        print("Seat Tapped")
        onTapFunc(seatDetail?.seat.seatName ?? "",seatDetail?.seat.price ?? 0)
    }
    
    func bindSeatArray( seat : SeatVO ){
        
        if seat.seat.type == TypeEnum.space {
            seatView.backgroundColor = UIColor.white
            seatLabel.text = seat.seat.seatName
        }
        else if seat.seat.type == TypeEnum.text {
            seatLabel.text = seat.seat.symbol
            seatView.backgroundColor = UIColor.white
        }
        else if seat.seat.type == TypeEnum.available {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(onTapSeat))
            self.seatView.isUserInteractionEnabled = true
            self.seatView.addGestureRecognizer(gesture)
            if seat.isSelected {
                seatLabel.text = ""
                seatView.backgroundColor = UIColor(named: "primaryColor") ?? UIColor.purple
                seatView.clipsToBounds = true
                seatView.layer.cornerRadius=8
                seatView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            } else {
                seatLabel.text = ""
                seatView.backgroundColor = UIColor(named: "availableColor") ?? UIColor.lightGray
                seatView.clipsToBounds=true
                seatView.layer.cornerRadius=8
                seatView.layer.maskedCorners=[ .layerMinXMinYCorner, .layerMaxXMinYCorner]
            }

            
        }
        else if seat.seat.type == TypeEnum.taken {
            seatLabel.text = ""
            seatView.backgroundColor = UIColor(named: "takenColor") ?? UIColor.darkGray
            seatView.clipsToBounds=true
            seatView.layer.cornerRadius=8
            seatView.layer.maskedCorners=[ .layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
    }
    
//    func bindData(seatVo: SeatVO){
//
//        if seatVo.isSeatEmpty() {
//            seatView.backgroundColor = UIColor.white
//            seatLabel.text = seatVo.title
//
//
//        } else if seatVo.isSeatTitle() {
//            seatLabel.text = seatVo.title
//            seatView.backgroundColor = UIColor.white
//
//        } else if seatVo.isSeatAvailable() {
//            seatLabel.text = seatVo.title
//            seatView.backgroundColor = UIColor(named: "availableColor") ?? UIColor.lightGray
//            seatView.clipsToBounds=true
//            seatView.layer.cornerRadius=8
//            seatView.layer.maskedCorners=[ .layerMinXMinYCorner, .layerMaxXMinYCorner]
//
//        } else if seatVo.isSeatSelected() {
//            seatLabel.text = seatVo.title
//            seatView.backgroundColor = UIColor(named: "primaryColor")
//            seatView.clipsToBounds=true
//            seatView.layer.cornerRadius=8
//            seatView.layer.maskedCorners=[ .layerMinXMinYCorner, .layerMaxXMinYCorner]
//        } else {
//            seatLabel.text = seatVo.title
//            seatView.backgroundColor = UIColor(named: "takenColor") ?? UIColor.darkGray
//            seatView.clipsToBounds=true
//            seatView.layer.cornerRadius=8
//            seatView.layer.maskedCorners=[ .layerMinXMinYCorner, .layerMaxXMinYCorner]
//
//        }
//
//    }

}
