import UIKit

class secondTableViewCell: UITableViewCell {
    
    @IBOutlet weak var paymentTableView: UITableView!
    
    let networkAgent = NetworkAgent.shared
    
    var payMethodsData : [PayMethod]?
    var payMethodArray : [PayMethodVO] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        
        paymentTableView.dataSource=self
        paymentTableView.delegate=self
        paymentTableView.registerCell(identifier: paymethodTableViewCell.idenfifier)
        
        initialFunc()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func initialFunc(){
        networkAgent.PayMethod { result in
            switch result{
            case .success(let data):
                self.payMethodsData = data.data
                self.payMethodArray.removeAll()
                data.data?.forEach({ method in
                    self.payMethodArray.append(PayMethodVO(method: method, isSelected: false))
                })
                self.paymentTableView.reloadData()
            case .failure(let message): print(message)
            }
        }
    }
}

extension secondTableViewCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return payMethodsData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueCell(identifier: paymethodTableViewCell.idenfifier, indexPath: indexPath) as! paymethodTableViewCell
        cell.data = payMethodArray[indexPath.row]
        cell.onTapFunc = { id in
            self.payMethodArray.forEach { method in
                if method.method.id == id {
                    method.isSelected = true
                } else {
                    method.isSelected = false
                }
            }
            self.paymentTableView.reloadData()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(70)
    }
}
