import UIKit
import SideMenu

class AddCardViewController: UIViewController {
    
    let networkAgent = NetworkAgent.shared
    
    var cinemaID : Int = 0
    var slotID : Int = 0
    var date : String = ""
    var amount: Int = 0
    var seatArray: [SeatVO] = []
    var cinemaName: String = ""
 //   var cinemaType : String = ""
    var movieID: Int = 0
    var posterpath: String = ""
    var selectedSnacks : [SnackVO] = []
    var dataObject: DataObject!

    
    @IBOutlet weak var cardNumberTF: UITextField!
    @IBOutlet weak var cvcTF: UITextField!
    @IBOutlet weak var expDateTF: UITextField!
    @IBOutlet weak var cardHolderTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        underlinedTF(textFieldName: cardNumberTF)
        underlinedTF(textFieldName: cvcTF)
        underlinedTF(textFieldName: expDateTF)
        underlinedTF(textFieldName: cardHolderTF)
        
        
        
    }
    
    func initFunc(number:String, holder:String, date:String, cvc:String){
        networkAgent.createCard(card_no: number, card_holder: holder, exp_date: date, cvc: cvc) { [self] result in
            switch result{
            case .success(let data):
                print(data)
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: ChooseCardViewController.self)) as! ChooseCardViewController
                
                vc.dataObject = dataObject
                vc.modalPresentationStyle = .fullScreen
                vc.modalTransitionStyle = .coverVertical
                self.present(vc, animated: true, completion: nil)
            case .failure(let message):print(message)
            }
        }
    }
    
    @IBAction func confirmButton(_ sender: UIButton) {
        
        initFunc(number: cardNumberTF.text ?? "", holder: cardHolderTF.text ?? "", date: expDateTF.text ?? "", cvc: cvcTF.text ?? "")
        
        
    }
    
    @IBAction func backbutton(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: ChooseCardViewController.self)) as! ChooseCardViewController
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .coverVertical
        present(vc, animated: true, completion: nil)
    }
}
