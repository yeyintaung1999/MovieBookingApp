import UIKit
import RxCocoa
import RxSwift

class SeatViewController: UIViewController {
        
    var dataObject: DataObject!
    
    var disposeBag = DisposeBag()
        
    @IBOutlet weak var alertView : UIView!
    @IBOutlet weak var buyButtonView : UIView!
    @IBOutlet weak var buyButton: UILabel!
    @IBOutlet weak var seatCountLabel: UILabel!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var cinemaNameLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var seatNamesLabel: UILabel!
    
    @IBOutlet weak var ivBack: UIImageView!
    @IBOutlet weak var seatCollectionView: UICollectionView!
    
    var weekdayName = ""
    var monthName = ""
    
    let formatter = DateFormatter()
    
    var viewModel: SeatPlanViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatter.locale = Locale(identifier: "en")
        formatter.dateFormat = "yyyy-MM-dd"
        setupDays()
        alertView.isHidden = true
        
        
        seatCollectionView.delegate=self
        seatCollectionView.registerCell(identifier: SeatCollectionViewCell.idenfifier)
        
        viewModel = SeatPlanViewModel()
        viewModel.selectedSeats.removeAll()
        
        setupSeatCollectionView()
                
        tapGesture()
        
        self.cinemaNameLabel.text = dataObject.cinemaName
        self.movieNameLabel.text = dataObject.movieDetail.originalTitle
        self.dateTimeLabel.text = "\(weekdayName), \(Calendar.current.component(.day, from: dataObject.date)) \(monthName), \(self.dataObject.slot.startTime ?? "default")"
        
    }
    
    @IBAction func buyTicketButton(_ sender: UIButton) {
        
    }
    
    func tapGesture(){
        let tapgestforivback = UITapGestureRecognizer(target: self, action: #selector(onTapBack))
        ivBack.isUserInteractionEnabled = true
        ivBack.addGestureRecognizer(tapgestforivback)
        
        self.buyButtonView.isUserInteractionEnabled = true
        let buyGesture = UITapGestureRecognizer(target: self, action: #selector(tapBuyButton))
        self.buyButtonView.addGestureRecognizer(buyGesture)
    }
    
    @objc func onTapBack(){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: ChooseDateTimeViewController.self)) as! ChooseDateTimeViewController
        vc.dataObject = self.dataObject
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @objc func tapBuyButton(){
        
        if viewModel.handleDidSelectSeat() {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: PromoViewController.self)) as! PromoViewController
            dataObject.selectedSeat = viewModel.selectedSeats
            vc.dataObject = dataObject
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        } else {
            alertView.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.alertView.isHidden = true
            }
        }
        
    }
    
    func setupSeatCollectionView(){
        viewModel.getSeatToBindData(id: dataObject.cinemaID, date: formatter.string(from: dataObject.date))
            .bind(to: seatCollectionView.rx.items(
                cellIdentifier: SeatCollectionViewCell.idenfifier,
                cellType: SeatCollectionViewCell.self)){ (row,element,cell) in
                    cell.seatDetail = element
                    cell.onTapFunc = { name,price in
                        self.viewModel.tapToSelectSeat(name: name, price: price)
                        self.seatCollectionView.reloadData()
                        self.seatCountLabel.text = "\(self.viewModel.selectedSeats.count)"
                        self.seatNamesLabel.text = self.viewModel.selectedSeats.compactMap{$0.seat.seatName}.joined(separator: ",")
                        var totalprice = 0
                        self.viewModel.selectedSeats.forEach { seat in
                            totalprice+=seat.seat.price ?? 0
                        }
                        self.buyButton.text = "Buy Ticket for $\(totalprice).00"
                    }
                }
                .disposed(by: disposeBag)
    }
    
    
}

extension SeatViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/14, height: 30)
    }
    
    func setupDays(){
        switch Calendar.current.component(.weekday, from: dataObject.date){
        case 1:
            weekdayName = "Sunday"
        case 2:
            weekdayName = "Monday"
        case 3:
            weekdayName = "Tuesday"
        case 4:
            weekdayName = "Wednesday"
        case 5:
            weekdayName = "Thursday"
        case 6:
            weekdayName = "Friday"
        case 7:
            weekdayName = "Saturday"
        default :
            weekdayName = "default"
        }
        
        switch Calendar.current.component(.month, from: dataObject.date){
        case 1:
            monthName = "Jan"
        case 2:
            monthName = "Feb"
        case 3:
            monthName = "Mar"
        case 4:
            monthName = "Apr"
        case 5:
            monthName = "May"
        case 6:
            monthName = "Jun"
        case 7:
            monthName = "Jul"
        case 8:
            monthName = "Aug"
        case 9:
            monthName = "Sep"
        case 10:
            monthName = "Oct"
        case 11:
            monthName = "Nov"
        case 12:
            monthName = "Dec"
        default :
            monthName = "default"
        }
    }

}

