import UIKit

class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        fetchProfile()
        
        self.view.addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        
    }
   var profileImageView = CustomImageView()
    
    func fetchProfile() {
        APICaller.shared.getCurrentUserProfile(completion: { result in
            DispatchQueue.main.async {
                switch result {
                case.success(let model):
                    self.updateUI(with: model)
                    print(model)
                    break
                case.failure(let error):
                    print("Profile Error: \(error.localizedDescription)")
                    self.failedToGetProfile()
                }
            }
            
        })
    }
 
    func updateUI(with model : UserProfile) {
        print(model)
     
        profileImageView.loadImage(with: model.images[0].url)

    }
    func failedToGetProfile() {
        print("Failed to get profile")
    }
   
    
}
