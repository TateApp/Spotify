import UIKit
protocol signInCompleted {
    func passBack()
}
class WelcomeViewController: UIViewController, signInCompleted {
    func passBack() {
        print("Passed Back")
        signInCompleted?.passBack()
    }
 
    var signInCompleted  : signInCompleted?
    let MillionsOfSongs = UILabel()
    let imageView = UIImageView()
    
    let loginButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .init(rbg: 18, green: 18, blue: 18, alpha: 1)
        
        setupViews()
   

  
    }
    let signInDetails = UILabel()
    
    func setupViews() {
        self.view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: UIScreen.main.bounds.height / 4).isActive = true
        imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.image = UIImage(imageLiteralResourceName: "Login Symbol")
        
        self.view.addSubview(MillionsOfSongs)
        MillionsOfSongs.translatesAutoresizingMaskIntoConstraints = false
        MillionsOfSongs.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 20).isActive = true
        MillionsOfSongs.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        MillionsOfSongs.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -19).isActive = true
        MillionsOfSongs.centerXAnchor.constraint(equalTo: self.imageView.centerXAnchor).isActive = true
        MillionsOfSongs.text =
"""
Millions of songs.
Free on Spotify.
"""
        MillionsOfSongs.font = .boldSystemFont(ofSize: 30)
        MillionsOfSongs.textColor = .white
        MillionsOfSongs.numberOfLines = .max
        MillionsOfSongs.textAlignment = .center
        
      
        self.view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.topAnchor.constraint(equalTo: MillionsOfSongs.bottomAnchor, constant: 30).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive  = true
        loginButton.setTitle("Login", for: .normal)
        loginButton.layer.cornerRadius = 25
        loginButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
        loginButton.backgroundColor = .init(rbg: 101, green: 212, blue: 110, alpha: 1)
        loginButton.setTitleColor( .black, for: .normal)
        loginButton.addTarget(self, action: #selector(tapDown(sender:)), for: .touchDown)
        loginButton.addTarget(self, action: #selector(tapUp(sender:)), for: .touchUpInside)
        
        self.view.addSubview(signInDetails)
        signInDetails.translatesAutoresizingMaskIntoConstraints = false
        signInDetails.topAnchor.constraint(equalTo: self.loginButton.bottomAnchor, constant: 20).isActive = true
        signInDetails.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        signInDetails.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -19).isActive = true
        signInDetails.centerXAnchor.constraint(equalTo: self.loginButton.centerXAnchor).isActive = true
        signInDetails.text =
"""
Sign in with
Username: tateAppDeveloper@outlook.com
Password: Portfolio123
"""
        signInDetails.font = .boldSystemFont(ofSize: 20)
        signInDetails.textColor = .white
        signInDetails.numberOfLines = .max
        signInDetails.textAlignment = .center
       
    }
    @objc func tapDown(sender: UIButton ) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .allowAnimatedContent, animations: {
            sender.transform = .init(scaleX: 0.8, y: 0.8)
        }, completion: nil)
    }
    @objc func tapUp(sender: UIButton ) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .allowAnimatedContent, animations: {
            sender.transform = .identity
        }, completion: { done in
            if done {
                self.signUpButtonPressed(sender: sender)
            }
        })
    }
    @objc func signUpButtonPressed(sender: UIButton) {
        let vc = AuthViewController()
        vc.protocolVar = self
        guard self.navigationController?.topViewController == self else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
   
}
