import UIKit

class LogInViewController: UIViewController {
    
    let googleAuth = GoogleAuth()
    
    let networkAgent = NetworkAgent.shared
    
    var logindata : LoginDataClass?
    
    var type : loginType = .login
    
    
    
    @IBOutlet weak var googlebutton: UIButton!
    @IBOutlet weak var phoneTf: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var alertview: UIView!
    @IBOutlet weak var alertLabel: UILabel!
    
    
    @IBOutlet weak var viewfacebook: UIView!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var signinView: UIView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var loginoverlay: UIView!
    @IBOutlet weak var signinLabel: UILabel!
    @IBOutlet weak var signinoverlay: UIView!
    @IBOutlet weak var facebookSignin: UIView!
    @IBOutlet weak var googleSignin: UIView!
    
    @IBOutlet weak var facebookbutton: UIButton!
    @IBOutlet weak var loginsignincollectionview: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alertview.isHidden = true
        
        facebookSignin.layer.borderColor = UIColor.lightGray.cgColor
        facebookSignin.layer.borderWidth = 1
        facebookSignin.layer.cornerRadius = 5
        
        googleSignin.layer.borderColor = UIColor.lightGray.cgColor
        googleSignin.layer.borderWidth = 1
        googleSignin.layer.cornerRadius = 5
        
        italicPlaceholder(placeholdertf: phoneTf, text: "Enter Your Phone Number")
        italicPlaceholder(placeholdertf: nameTF, text: "Enter Your Name")
        italicPlaceholder(placeholdertf: passwordTF, text: "Enter Password")
        italicPlaceholder(placeholdertf: emailTF, text: "Enter Your Email")
        
        underlinedTF(textFieldName: phoneTf)
        underlinedTF(textFieldName: nameTF)
        underlinedTF(textFieldName: passwordTF)
        underlinedTF(textFieldName: emailTF)
        
        tapGestForLogin()
        tapGestForSignin()
        
        nameView.isHidden=true
        phoneView.isHidden=true
        
        tapgestureforGoogleFacebookButton()
        
    }
    
    enum loginType : String {
        case login = "Login"
        case signin = "Register"
    }
    
    func tapgestureforGoogleFacebookButton(){
        
        googleSignin.isUserInteractionEnabled = true
        let googleGesture = UITapGestureRecognizer(target: self, action: #selector(onTapGoogle))
        googleSignin.addGestureRecognizer(googleGesture)
        
    }
    
    func FetchEmailLoginData(){
        
        let emailText = emailTF.text
        let passwordText = passwordTF.text
        
        
        networkAgent.loginWithEmail(email: emailText!, password: passwordText!) { [weak self] result in
            guard let self = self else {return}
            print("Login Network works")
            switch result {
            case .success(let data):
                
                switch data.code! {
                case 200...299:
                    self.logindata = data.data
                    setDefaults(name: data.data?.name ?? "default", token: data.token ?? "", profilePath: data.data?.profileImage ?? "", password: passwordText!, email: emailText!)
                    self.navigateToNextVC(data: data.data!)
                default:
                    self.alertLabel.textColor = UIColor.red
                    self.alertLabel.text = "\(data.message ?? "Login Failed")"
                    self.alertview.isHidden = false // show noti alert
                    DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                        self.alertview.isHidden=true
                    }
                }
            case .failure(let message): print(message)
            }
        }
        
    }
    
    func navigateToNextVC(data: LoginDataClass){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: MainScreenViewController.self)) as! MainScreenViewController
            
        
        
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
    }
    
    func FetchEmailRegisterData(){
        let nameText = nameTF.text
        let emailText = emailTF.text
        let phoneText = phoneTf.text
        let passwordText = passwordTF.text
        
        networkAgent.registerWithEmail(name: nameText!, email: emailText!, phone: phoneText!, password: passwordText!, google: "1212", facebook: "78987") { [weak self] (result) in

            guard let self = self else {return}
            switch result {
            case .success( _):
                self.alertLabel.textColor = UIColor.green
                self.alertLabel.text = "Account Created Successfully!"
                self.alertview.isHidden = false
                DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                    self.alertview.isHidden=true
                    self.tapLogin()
                }
                
                
            case .failure(let message):
                print(message)
                let emailtext = emailText ?? ""
                let passwordtext = passwordText ?? ""
                if emailtext.contains("@") == false{
                    self.alertLabel.textColor = UIColor.red
                    self.alertLabel.text = "Invalid Email"
                    self.alertview.isHidden = false
                    DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                        self.alertview.isHidden=true
                    }
                }else if passwordtext.count<6 {
                        self.alertLabel.textColor = UIColor.red
                        self.alertLabel.text = "At least 6 Characters for Password"
                        self.alertview.isHidden = false
                        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                            self.alertview.isHidden=true
                    }
                }
            }
        }
    }
    
    func italicPlaceholder(placeholdertf:UITextField, text: String){
        placeholdertf.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.font:UIFont.italicSystemFont(ofSize: 18)])
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        print("Login Button Pressed")
        switch type {
        case .login:
            FetchEmailLoginData()
        case .signin:
            FetchEmailRegisterData()
        }
  
    }
    
    
    
    func tapGestForLogin(){
        let tapGestRecognizerLogin = UITapGestureRecognizer(target: self, action: #selector(tapLogin))
        loginView.isUserInteractionEnabled=true
        loginView.addGestureRecognizer(tapGestRecognizerLogin)
        
    }
    
    func tapGestForSignin(){
        let tapGestRecognizerSignin = UITapGestureRecognizer(target: self, action: #selector(tapSignin))
        signinView.isUserInteractionEnabled=true
        signinView.addGestureRecognizer(tapGestRecognizerSignin)
    }
    
    @objc func tapLogin(){
        phoneTf.text?.removeAll()
        emailTF.text?.removeAll()
        nameTF.text?.removeAll()
        passwordTF.text?.removeAll()
        type = .login
        nameView.isHidden=true
        phoneView.isHidden=true
        loginLabel.textColor=UIColor(named: "primaryColor")
        loginoverlay.backgroundColor=UIColor(named: "primaryColor")
        signinLabel.textColor=UIColor.black
        signinoverlay.backgroundColor=UIColor.white
    }
    
    @objc func tapSignin(){
        phoneTf.text?.removeAll()
        emailTF.text?.removeAll()
        nameTF.text?.removeAll()
        passwordTF.text?.removeAll()

        type = .signin
        nameView.isHidden=false
        phoneView.isHidden=false
        loginoverlay.backgroundColor=UIColor.white
        loginLabel.textColor=UIColor.black
        signinLabel.textColor=UIColor(named: "primaryColor")
        signinoverlay.backgroundColor=UIColor(named: "primaryColor")
        
    }
    
    @objc func onTapGoogle(){
        
        googleAuth.start(view: self, success: { (data) in
            print("google signin Success")
            print("\(data)")
            
        }) { (err) in
           print(err)
        }
         
    }
    
}
