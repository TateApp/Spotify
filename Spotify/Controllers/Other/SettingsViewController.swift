import UIKit


class SettingsViewCotroller: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    var sections = [Section]()
    func configureModel() {
        sections.append(Section(title: "Profile", option: [Option(title: "View Your Profile", handler: { [weak self] in
            DispatchQueue.main.async {
                self?.viewProfile()
            }
        })
                                                          ]))
       sections.append(Section(title: "Acount", option: [Option(title: "Sign out", handler: { [weak self] in
           DispatchQueue.main.async {
               self?.signOutTapped()
           }
       })
                                                        ]))
      
    }
    func viewProfile() {
        let vc = ProfileViewController()
        guard self.navigationController?.topViewController == self else { return }
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    func signOutTapped() {
        
    }
}
