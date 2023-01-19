import UIKit

class PromoViewController: UIViewController, PayButtonDelegate {
    
    func onTapPayButton() {
    }
    
    var dataObject: DataObject!
    
   // var slot : Timeslot?
    //var cinemaName: String?
 //   var datetogetback : Date?
    
    //var date : String=""
    //var slotID : Int = 0
    var totalAmount : Int = 0
    //var cinemaID : Int = 0
//    var seatArray : [SeatVO]?{
//        didSet{
//            if let seatArray = seatArray {
//                seatArray.forEach { seat in
//                    totalAmount+=seat.seat.price ?? 0
//                }
//            }
//        }
//    }
    
    @IBOutlet weak var PayButton: UIView!
    @IBOutlet weak var payButtonLabel : UILabel!
    @IBOutlet weak var paymethodTableView: UITableView!
    @IBOutlet weak var enterPromoTableView: UITableView!
    @IBOutlet weak var firstTableView: UITableView!
    @IBOutlet weak var backiv: UIImageView!
    var totalCost1 = 0
    var totalCost2 = 0
    var totalCost3 = 0
    var profiledata : LoginDataClass?
    let networkAgent = NetworkAgent.shared
    let snackModel = SnackModelImpl.shared
        
    var snackData : [Snack]?
    var snackvoArray:[SnackVO] = []
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        dataObject.selectedSeat.forEach { seat in
            totalAmount+=seat.seat.price ?? 0
        }
        self.payButtonLabel.text = "Pay $\(totalAmount).00"
        print("\(dataObject.selectedSeat.count)")
        print("\(totalAmount)")
        totalCost1 = 0
        totalCost2 = 0
        totalCost3 = 0
        
        tapGestureRecognizer()
        
        
        
        firstTableView.dataSource = self
        firstTableView.delegate = self
        firstTableView.registerCell(identifier: firstTableViewCell.idenfifier)
        
        enterPromoTableView.dataSource = self
        enterPromoTableView.delegate = self
        enterPromoTableView.registerCell(identifier: enterPromoTableViewCell.idenfifier)
        
        paymethodTableView.dataSource = self
        paymethodTableView.delegate = self
        paymethodTableView.registerCell(identifier: secondTableViewCell.idenfifier)
        
        initialFunc()
        
        self.PayButton.isUserInteractionEnabled = true
        let payGesture = UITapGestureRecognizer(target: self, action: #selector(pay))
        self.PayButton.addGestureRecognizer(payGesture)
    }
    @objc func pay(){
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: ChooseCardViewController.self)) as? ChooseCardViewController else {return}
        
        dataObject.amount = self.totalAmount+self.totalCost1+self.totalCost2+self.totalCost3
        //dataObject.selectedSnack.removeAll()
        dataObject.selectedSnack = snackvoArray
        
        vc.dataObject = dataObject
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }


    func tapGestureRecognizer(){
        
        let tapGestforback = UITapGestureRecognizer(target: self, action: #selector(onTapBackiv))
        backiv.isUserInteractionEnabled = true
        backiv.addGestureRecognizer(tapGestforback)
        
    }
    @objc func onTapBackiv(){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: SeatViewController.self)) as! SeatViewController
        vc.dataObject = dataObject
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .coverVertical
        present(vc, animated: true, completion: nil)
    }
    
    func initialFunc(){
        snackModel.SnackList { result in
            switch result{
            case .success(let data):
                self.snackvoArray.removeAll()
                self.snackData = data
                
                self.firstTableView.reloadData()
            case .failure(let message):print(message)
            }
        }
    }
    
}

extension PromoViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == firstTableView {
            return 1
        } else if tableView == enterPromoTableView {
            return 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == firstTableView {
            let cell = tableView.dequeueCell(identifier: firstTableViewCell.idenfifier, indexPath: indexPath) as! firstTableViewCell
            cell.totalAmount1 = {amount,id,count in
                if count != 0 {
                    self.snackvoArray.append(SnackVO(id: id, quantity: count))
                }
                self.totalCost1=amount
                self.payButtonLabel.text = "Pay $\(self.totalAmount+self.totalCost1+self.totalCost2+self.totalCost3).00"
            }
            cell.totalAmount2 = {amount,id,count in
                if count != 0 {
                    self.snackvoArray.append(SnackVO(id: id, quantity: count))
                }
                self.totalCost2=amount
                self.payButtonLabel.text = "Pay $\(self.totalAmount+self.totalCost1+self.totalCost2+self.totalCost3).00"
            }
            cell.totalAmount3 = {amount,id,count in
                if count != 0 {
                    self.snackvoArray.append(SnackVO(id: id, quantity: count))
                }
                self.totalCost3=amount
                self.payButtonLabel.text = "Pay $\(self.totalAmount+self.totalCost1+self.totalCost2+self.totalCost3).00"
            }
            return cell
        } else if tableView == enterPromoTableView {
            return tableView.dequeueCell(identifier: enterPromoTableViewCell.idenfifier, indexPath: indexPath)
        } else if tableView == paymethodTableView {
            let cell = tableView.dequeueCell(identifier: secondTableViewCell.idenfifier, indexPath: indexPath) as secondTableViewCell
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == firstTableView {
            return CGFloat(300)
        } else if tableView == enterPromoTableView {
            return CGFloat(180)
        } else {
            return CGFloat(300)
        }
    }
}
