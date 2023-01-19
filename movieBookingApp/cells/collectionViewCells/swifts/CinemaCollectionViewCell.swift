//
//  CinemaCollectionViewCell.swift
//  movieBookingApp
//
//  Created by Ye Yint Aung on 03/05/2022.
//

import UIKit

class CinemaCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var timeSlotCollectionView: UICollectionView!
    
    @IBOutlet weak var cinemaNameLabel: UILabel!
    var slotArray : [TimeSlotVO]?{
        didSet{
            timeSlotCollectionView.reloadData()
        }
    }
    
    var onTapTimeSlot : ((Int,String)->Void) = { _,_ in}

    var cinemaData : CinemaTimeSlot?{
        didSet{
            if let data = cinemaData {
                cinemaNameLabel.text = data.cinema
                
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        timeSlotCollectionView.dataSource = self
        timeSlotCollectionView.delegate = self
        timeSlotCollectionView.registerCell(identifier: TimeSlotCollectionViewCell.idenfifier)
        
    }
    
    
    

}

extension CinemaCollectionViewCell : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cinemaData?.timeslots?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(identifier: TimeSlotCollectionViewCell.idenfifier, indexPath: indexPath) as TimeSlotCollectionViewCell
        cell.timeslotData = self.slotArray?[indexPath.row]
        cell.onTapTimeSlot = { id,time in
            self.onTapTimeSlot(id,time)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3.3, height: collectionView.frame.height/2)
    }
    

}
