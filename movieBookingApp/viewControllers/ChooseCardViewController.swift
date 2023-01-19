import UIKit
import UPCarouselFlowLayout
import DGCarouselFlowLayout
import SystemConfiguration

class ChooseCardViewController: UIViewController {
    
    let networkAgent = NetworkAgent.shared
    
    
    @IBOutlet weak var addnewcardview: UIStackView!
    @IBOutlet weak var cardCollectionView: UICollectionView!
    @IBOutlet weak var amountLabel : UILabel!
    @IBOutlet weak var buyButton : UIButton!
    
    var dataObject: DataObject!


    //var cinemaID = 0
    //var seatArray : [SeatVO] = []
    //var slotID = 0
    var cardID : Int = 0
    var profiledata : LoginDataClass?
    //var amount : Int = 0
    //var date = ""
    //var cinemaName: String = ""
//    var cinemaType : String = ""
    //var movieID : Int = 0
    
    //var selectedSnacks : [SnackVO] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.amountLabel.text = "$\(dataObject.amount ?? 0).00"
        
        cardCollectionView.dataSource=self
        cardCollectionView.delegate=self
        cardCollectionView.registerCell(identifier: CardCollectionViewCell.idenfifier)
        
        let layout = UPCarouselFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sideItemScale = 0.7
//        layout.sideItemShift = 0
        layout.spacingMode = UPCarouselFlowLayoutSpacingMode.fixed(spacing: 0)
        layout.itemSize = CGSize(width: 320,height: 180)
        cardCollectionView.collectionViewLayout = layout
        
        
        tapGestureRecognizer()
        initCards()
        
        
        
    }
    
    func initCards(){
        networkAgent.loginWithEmail(email: defaults.string(forKey: "email")!, password: defaults.string(forKey: "password")!) { result in
            switch result {
            case .success(let data):
                self.profiledata = data.data
                if(data.data?.cards?.count ?? 0 < 1){
                    self.buyButton.isEnabled = false
                } else {
                    self.buyButton.isEnabled = true
                }
                self.cardCollectionView.reloadData()
            case.failure(let message): print(message)
            }
        }
        
    }
    
    func tapGestureRecognizer(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTap))
        
        addnewcardview.isUserInteractionEnabled = true
        addnewcardview.addGestureRecognizer(tapGesture)
    }
    
    @objc func onTap(){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: AddCardViewController.self)) as! AddCardViewController
        //vc.slotID = slotID
        //vc.seatArray = seatArray
        ///vc.amount = amount
        //vc.cinemaID = cinemaID
       // vc.movieDetail = movieDetail
        //vc.date = date
        //vc.cinemaName = cinemaName
        //vc.cinemaType = cinemaType
        //vc.selectedSnacks.removeAll()
        //vc.selectedSnacks = selectedSnacks
        
        vc.dataObject = dataObject
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .coverVertical
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func confirmButton(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: TicketViewController.self)) as! TicketViewController
        //vc.cardID = cardID
        //vc.totalprice = amount
        //vc.timeslotID = slotID
        //vc.bookingDate = date
        //vc.seatArray = seatArray
        //vc.cinemaID = cinemaID
        //vc.cinemaName = cinemaName
 //       vc.cinemaType = cinemaType
        //vc.selectedSnacks.removeAll()
        //vc.selectedSnacks=selectedSnacks
        
        vc.dataObject = dataObject
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .coverVertical
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: PromoViewController.self)) as! PromoViewController
        vc.dataObject = self.dataObject
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .coverVertical
        present(vc, animated: true, completion: nil)
    }
}

extension ChooseCardViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profiledata?.cards?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(identifier: CardCollectionViewCell.idenfifier, indexPath: indexPath) as! CardCollectionViewCell
        cell.card = profiledata?.cards?[indexPath.row]
        return cell
    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.frame.width/1.5, height: 180)
//    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cardID = self.profiledata?.cards?[indexPath.row].id ?? -1
        dataObject.cardID = self.profiledata?.cards?[indexPath.row].id ?? -1
        
    }
    
    
}

