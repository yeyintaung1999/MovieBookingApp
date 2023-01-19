//
//  SideSliderViewController.swift
//  movieBookingApp
//
//  Created by Ye Yint Aung on 21/05/2022.
//

import UIKit

class SideSliderViewController: UIViewController {
    
    @IBOutlet weak var logOutStack: UIStackView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        let imageurl = "\(baseUrl)\(defaults.string(forKey: "profile") ?? "")"
        name.text = defaults.string(forKey: "name")
        
        email.text = defaults.string(forKey: "email")
        
        profileImage.sd_setImage(with: URL(string: imageurl))

        logoutFunc()
        // Do any additional setup after loading the view.
    }
    
    func logoutFunc(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapLogout))
        logOutStack.isUserInteractionEnabled = true
        logOutStack.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func onTapLogout(){
        let domain = Bundle.main.bundleIdentifier!
        defaults.removePersistentDomain(forName: domain)
        defaults.synchronize()
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: ViewController.self)) as? ViewController else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .coverVertical
        present(vc, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
