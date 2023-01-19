import UIKit
import Alamofire

class ChooseDateTimeViewController: UIViewController {
    
    var dataObject: DataObject!
    
    let timeSlotModel = TimeSlotModelImpl.shared
    
    var networkAgent = NetworkAgent.shared
    var cinemaData : [CinemaTimeSlot]?
    var dateString : String = ""
    let year = Calendar.current.component(.year, from: Date())
    let month = Calendar.current.component(.month, from: Date())
    let day = Calendar.current.component(.day, from: Date())
    var profiledata : LoginDataClass?
    var dateArray : [dateVO] = []
    var slotArray : [TimeSlotVO] = []
    var cinemaTypeArray : [cinemaType] = []
    
    @IBOutlet weak var alertView : UIView!
    @IBOutlet weak var collectionViewA: UICollectionView!
    @IBOutlet weak var collectionViewB: UICollectionView!
    
    @IBOutlet weak var CinemaCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(dataObject.movieDetail)
        cinemaTypeArray.removeAll()
        dummycinema.forEach { item in
            cinemaTypeArray.append(item)
        }
        
        alertView.isHidden = true
        
        collectionViewA.dataSource = self
        collectionViewA.delegate = self
        collectionViewA.registerCell(identifier: cvACollectionViewCell.idenfifier)
        
        collectionViewB.dataSource = self
        collectionViewB.delegate = self
        collectionViewB.registerCell(identifier: cvBCDCollectionViewCell.idenfifier)
        
        CinemaCollectionView.dataSource = self
        CinemaCollectionView.delegate=self
        CinemaCollectionView.registerCell(identifier: CinemaCollectionViewCell.idenfifier)
        dateArray.removeAll()
        
        for i in 0...6 {
            if i == 0 {
                let date = Date()
                var dateComponent = DateComponents()
                dateComponent.day = i
                let newDate = Calendar.current.date(byAdding: dateComponent, to: date)
                
                dateArray.append(dateVO(date: newDate!, isSelected: true))
//                dateArray.append(dateVO(day: day+i, weekday: Int(Calendar.current.component(.weekday, from: Date()))+i, isSelected: true))

            } else {
                let date = Date()
                var dateComponent = DateComponents()
                dateComponent.day = i
                let newDate = Calendar.current.date(byAdding: dateComponent, to: date)
                dateArray.append(dateVO(date: newDate!, isSelected: false))
            }
        }
        
        initFunc()
        
    }
    
    func onTapDateVO(index:Int){
        self.dateArray.forEach { date in
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "yyyy-MM-dd"
            var addedDay = DateComponents()
            addedDay.day = index
            let newDate = Calendar.current.date(byAdding: addedDay, to: Date())
            
            if dateformatter.string(from: newDate!).split(separator: "-")[2] ==  dateformatter.string(from: date.date).split(separator: "-")[2]
            {
                date.isSelected = true
            } else {
                date.isSelected = false
            }
        }
        
        self.dateString = "\(self.year)-\(self.month)-\(Int(self.day)+(index))"
        self.timeSlotModel.CinemaTimeSlot(id: dataObject.movieDetail.id ?? 0, date: dateString) { result in
            
            switch result {
            case .success(let data):
                self.slotArray.removeAll()
                data.forEach({ cinema in
                    cinema.timeslots?.forEach({ timeslot in
                        self.slotArray.append(TimeSlotVO(name: cinema.cinema ?? "", id : cinema.cinemaID!,slot: timeslot, isSelected: false))
                    })
                })
                self.cinemaData = data
                
                self.CinemaCollectionView.reloadData()
                print("cinema collectionView reloaded")
                self.slotArray.forEach { item in
                    print(item.cinemaID)
                }
            case .failure(let error):
                print(error)
            }
        }
        self.collectionViewA.reloadData()
        
        
    }
    
    func initFunc(){
        dateString = "\(year)-\(month)-\(day)"
        timeSlotModel.CinemaTimeSlot(id: dataObject.movieDetail.id ?? 0, date: dateString) { result in
            switch result {
            case .success(let data):
                
                data.forEach({ cinema in
                    cinema.timeslots?.forEach({ timeslot in
                        self.slotArray.append(TimeSlotVO(name: cinema.cinema ?? "",id : cinema.cinemaID!,slot: timeslot, isSelected: false))
                    })
                })
                self.cinemaData = data
            
                self.collectionViewA.reloadData()
                self.CinemaCollectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: MainScreenViewController.self)) as! MainScreenViewController
        
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .coverVertical
        present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func nextButton(_ sender: Any) {
        
        var selectedSlots : [TimeSlotVO] = []
        selectedSlots.removeAll()
        slotArray.forEach { slot in
            if slot.isSelect {
                selectedSlots.append(slot)
            }
        }
        if selectedSlots.count < 1 {
            
            alertView.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.alertView.isHidden = true
            }
            
        } else {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: SeatViewController.self)) as! SeatViewController
            var cinemaID: Int = 0
            var cinemaName: String = ""
            var date: Date = Date()
            slotArray.forEach { item in
                if item.isSelect {
                    cinemaID = item.cinemaID
                    cinemaName = item.cinemaName
                    self.dataObject.slot = item.timeSlot
//                    vc.slot = item.timeSlot
                }
            }
            dateArray.forEach { item in
                if item.isSelected {
                    
                    date = item.date
                }
            }
            cinemaTypeArray.forEach { type in
                if type.isSelected {
                    dataObject.cinemaType = type.name
                    //vc.cinemaType = type.name
                }
            }
            dataObject.cinemaName = cinemaName
            dataObject.cinemaID = cinemaID
            dataObject.date = date
//            vc.cinemaName = cinemaName
//            vc.cinemaID = cinemaID
//            vc.date = date
            
            vc.dataObject = dataObject
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
    }
    
}

extension ChooseDateTimeViewController:UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewA {
            return dateArray.count
        } else if collectionView == collectionViewB { return 3 } else{ return cinemaData?.count ?? 0}
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewA {
            let cell = collectionView.dequeCell(identifier: cvACollectionViewCell.idenfifier, indexPath: indexPath) as! cvACollectionViewCell
            cell.date = dateArray[indexPath.row]
            
            return cell
        } else if collectionView == collectionViewB {
            let cell = collectionView.dequeCell(identifier: cvBCDCollectionViewCell.idenfifier, indexPath: indexPath) as! cvBCDCollectionViewCell
            cell.data = cinemaTypeArray[indexPath.row]
            cell.onTapFunc = { name in
                self.cinemaTypeArray.forEach{ type in
                    if type.name == name {
                        type.isSelected = true
                    } else {
                        type.isSelected = false
                    }
                }
                self.collectionViewB.reloadData()
            }
            return cell
        } else {
            let cell = collectionView.dequeCell(identifier: CinemaCollectionViewCell.idenfifier, indexPath: indexPath) as! CinemaCollectionViewCell
            cell.cinemaData = cinemaData?[indexPath.row]
            var array : [TimeSlotVO]=[]
            array.removeAll()
            self.slotArray.forEach { item in
                if item.cinemaID == cinemaData?[indexPath.row].cinemaID {
                    array.append(item)
                }
            }
            cell.onTapTimeSlot = { id,time in
                self.slotArray.forEach { slot in
                    if slot.cinemaID==id && slot.timeSlot.startTime==time{
                        slot.isSelect = true
                    }
                    else { slot.isSelect = false }
                }
                self.CinemaCollectionView.reloadData()
            }
            
            cell.slotArray = array
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        if collectionView == collectionViewA {
            return CGSize(width: collectionView.frame.width/5, height: 70)
        } else
        if collectionView == collectionViewB {
            return CGSize(width: collectionView.frame.width/3.3, height: collectionView.frame.width/8)
        } else
        {
            return CGSize(width: collectionView.frame.width, height: 130)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewA {
            onTapDateVO(index: indexPath.row)
            
        }
    }
}
