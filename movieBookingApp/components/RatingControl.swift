import Foundation
import UIKit

@IBDesignable
class RatingControl: UIStackView{
    
    @IBInspectable var buttonSize:CGSize = CGSize(width: 16, height: 16) {
        didSet{
            setupButton()
            updateButtonRating()
        }
    }
    
    @IBInspectable var starCount:Int = 5 {
        didSet{
            setupButton()
            updateButtonRating()
        }
    }
    
    @IBInspectable var rating:Int = 0 {
        didSet{
            setupButton()
            updateButtonRating()
        }
    }

    @IBInspectable var ratingButton=[UIButton]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    func setupButton(){
        
        clearExistingButton()
        for _ in 1..<starCount+1{
            let button = UIButton()
            
            button.translatesAutoresizingMaskIntoConstraints = false
            
            button.setImage(UIImage(named: "selectedStar"), for: .selected)
            button.setImage(UIImage(named: "emptyStar"), for: .normal)
            
            button.heightAnchor.constraint(equalToConstant: buttonSize.height-2).isActive=true
            button.widthAnchor.constraint(equalToConstant: buttonSize.width-2).isActive=true
            
            addArrangedSubview(button)
            button.isUserInteractionEnabled=false
            
            ratingButton.append(button)
        }
    }
    
    func updateButtonRating(){
        for(index,button) in ratingButton.enumerated(){
            button.isSelected = index < rating
        }
    }
    
    func clearExistingButton(){
        for button in ratingButton {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButton.removeAll()
    }
}

