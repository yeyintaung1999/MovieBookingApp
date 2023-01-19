//
//  ViewController.swift
//  movieBookingApp
//
//  Created by Ye Yint Aung on 21/02/2022.
//

import UIKit

class ViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        

    }
    
    @IBAction func getStartButton(_ sender: UIButton) {
        
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: LogInViewController.self)) as? LogInViewController else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .coverVertical
        present(vc, animated: true)
        
    }
    
    
}

