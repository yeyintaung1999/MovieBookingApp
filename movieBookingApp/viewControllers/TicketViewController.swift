import UIKit
import SDWebImage

class TicketViewController: UIViewController {
    
    @IBOutlet weak var clearimageview: UIImageView!
    
    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var screenTime: UILabel!
    @IBOutlet weak var bookingNumberLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var cinemaNameLabel : UILabel!
    @IBOutlet weak var screenLabel: UILabel!
    @IBOutlet weak var rowLabel: UILabel!
    @IBOutlet weak var seatNameLabel: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var qrCodeImage: UIImageView!
    
    let networkAgent = NetworkAgent.shared
    var seatArray : [SeatVO]?{
        didSet{
            if let seatArray = seatArray {
                
            
            }
        }
    }
    var row : String = ""
    var seatNumber: String = ""
    var selectedSnacks : [SnackVO] = []
    
    var dataObject: DataObject!

    var checkoutDetail : CheckoutResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapGestureForClear()
        initialFunc()
        
    }
    
    func initialFunc(){
        
        seatNumber = (dataObject.selectedSeat.compactMap{$0.seat.seatName}.joined(separator: ","))
        row = "\(dataObject.selectedSeat[0].seat.seatName?.split(separator: "-")[0] ?? "A")"
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en")
        formatter.dateFormat = "yyyy-MM-dd"
        
        //print("\(defaults.string(forKey: "token"))")
        
        networkAgent.checkOut(
            timeslotID: dataObject.slot.cinemaDayTimeslotID ?? 0,
            row: row,
            seatNumber: seatNumber,
            bookingDate: formatter.string(from: dataObject.date),
            totalPrice: dataObject.amount,
            movieID: dataObject.movieDetail.id!,
            cardID: dataObject.cardID,
            cinemaID: dataObject.cinemaID,
            snacks: dataObject.selectedSnack) { result in
            switch result{
            case .success(let data):
                print(data)
                self.bindData(data: data)
            case .failure(let message): print(message)
            }
        }
    }
    
    func bindData(data: CheckoutResponse){
        bookingNumberLabel.text = data.data?.bookingNo
        dateTimeLabel.text = data.data?.timeslot?.startTime ?? ""
        screenLabel.text = "\(dataObject.selectedSeat.count)"
        rowLabel.text = self.row
        seatNameLabel.text = data.data?.seat ?? ""
        price.text = "$\(dataObject.amount!)"
        let imageurl = "\(imageBaseUrl)/\(self.dataObject.movieDetail.posterPath ?? "")"
        self.backdropImage.sd_setImage(with: URL(string: imageurl))
        self.movieName.text = dataObject.movieDetail.originalTitle ?? "undefined"
        self.screenTime.text = "\(dataObject.movieDetail.runtime ?? 0)m - \(dataObject.cinemaType ?? "IMAX")"
        self.cinemaNameLabel.text = "\(dataObject.cinemaName ?? "")"
    }
    
    func tapGestureForClear(){
        let tapgest = UITapGestureRecognizer(target: self, action: #selector(onTapClear))
        clearimageview.isUserInteractionEnabled = true
        clearimageview.addGestureRecognizer(tapgest)
    }
    
    @objc func onTapClear(){
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: MainScreenViewController.self)) as? MainScreenViewController else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .coverVertical
        present(vc, animated: true, completion: nil)
    }
}
