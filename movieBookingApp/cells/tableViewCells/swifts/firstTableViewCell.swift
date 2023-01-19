//
//  firstTableViewCell.swift
//  movieBookingApp
//
//  Created by Ye Yint Aung on 28/02/2022.
//

import UIKit

class firstTableViewCell: UITableViewCell {
    
    let networkAgent = NetworkAgent.shared

    @IBOutlet weak var firstComboTableView: UITableView!
    var snackData : [Snack]?
    var totalAmount1 : ((Int,Int,Int)->Void) = { _,_,_ in}
    var totalAmount2 : ((Int,Int,Int)->Void) = { _,_,_ in}
    var totalAmount3 : ((Int,Int,Int)->Void) = {_,_,_ in}
    override func awakeFromNib() {
        super.awakeFromNib()
        
        firstComboTableView.dataSource=self
        firstComboTableView.delegate=self
        firstComboTableView.registerCell(identifier: ComboTableViewCell.idenfifier)
        
        initialFunc()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initialFunc(){
        networkAgent.SnackList { result in
            switch result{
            case .success(let data):
                self.snackData = data.data
                self.firstComboTableView.reloadData()
            case .failure(let message):print(message)
            }
        }
    }
    
}

extension firstTableViewCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snackData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(identifier: ComboTableViewCell.idenfifier, indexPath: indexPath) as! ComboTableViewCell
        if indexPath.row == 0 {
            cell.onTap = {count,price,id in
                self.totalAmount1(price*count,id,count)
            }
        }else if indexPath.row == 1 {
            cell.onTap = { count,price,id in
                self.totalAmount2(price*count,id,count)
            }
        }else {
            cell.onTap = {count,price,id in
                self.totalAmount3(price*count,id,count)
            }
        }
        cell.data = snackData?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
    }
}
