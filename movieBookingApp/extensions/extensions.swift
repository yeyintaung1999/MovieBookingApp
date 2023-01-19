import Foundation
import UIKit

enum storyboardName : String {
    case Main = "Main"
    case LaunchScreen = "LaunchScreen"
}

extension UIStoryboard {
    static func mainStoryBoard()->UIStoryboard{
        UIStoryboard(name: storyboardName.Main.rawValue, bundle: nil)
    }
}

extension UICollectionViewCell{
    static var idenfifier : String{
        String(describing: self)
    }
}

extension UITableViewCell{
    static var idenfifier : String{
        String(describing: self)
    }
}

extension UICollectionView{
    func registerCell(identifier: String)->Void{
        register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
    }
    func dequeCell<T:UICollectionViewCell>(identifier: String, indexPath: IndexPath)->T{
        guard let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
            return UICollectionViewCell() as! T
        }
        return cell
    }
}

extension UITableView{
    func registerCell(identifier: String)->Void{
        register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    func dequeueCell<T:UITableViewCell>(identifier: String, indexPath: IndexPath)->T{
        guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
            return UITableViewCell() as! T
        }
        return cell
    }
}


extension UIViewController {
    func underlinedTF(textFieldName:UITextField){
        let bottomline = CALayer()
        bottomline.backgroundColor = UIColor(named: "availableColor")?.cgColor
        bottomline.frame = CGRect(x: 0, y: textFieldName.frame.height, width: textFieldName.frame.width, height: 1)
        textFieldName.borderStyle = UITextField.BorderStyle.none
        textFieldName.layer.addSublayer(bottomline)
    }
}


