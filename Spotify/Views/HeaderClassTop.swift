import UIKit
protocol signOutPressed {
    func signOutPressed()
}
class HeaderClassTop: UICollectionReusableView {
    var protocolVar: signOutPressed?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        self.backgroundColor = .blue
    }
   
    let sectionLabel = UILabel()
    let whatsNewButton = UIButton()
    let recentlyPlayed = UIButton()
    let settingsButton = UIButton()
    func configure(sectionHeader: String) {
       
        self.addSubview(sectionLabel)
        sectionLabel.translatesAutoresizingMaskIntoConstraints = false
        sectionLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        sectionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        sectionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        sectionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        sectionLabel.text = sectionHeader
        sectionLabel.textAlignment = .left
        sectionLabel.textColor = .white
        sectionLabel.font = .boldSystemFont(ofSize: 20)
        
        self.addSubview(settingsButton)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        settingsButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        settingsButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        settingsButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
//        settingsButton.backgroundColor = .white
        settingsButton.setImage(UIImage.init(imageLiteralResourceName: "Login Symbol"), for: .normal)
        
        settingsButton.addTarget(self, action: #selector(signOutPressed(sender:)), for: .touchUpInside)
    }
    @objc func signOutPressed(sender: UIButton) {
        protocolVar!.signOutPressed()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
