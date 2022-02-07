import UIKit


class DeciderViewController: UIViewController, signedOut, signInCompleted {
    func passBack() {
        print("Signed In")
        welcomeViewController!.dismiss(animated: true, completion: nil)
  
        checkSignIn()
        
      
    }
    
    func _signedOut() {
        print("Signed Out!")
        MainController?.dismiss(animated: true, completion: nil)
        checkSignIn()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        checkSignIn()
        
    }
    var nav : UINavigationController?
    var welcomeViewController : WelcomeViewController?
    var MainController : TabBarController?
    func checkSignIn() {
        if AuthManager.shared.isSignedIn {
            print("Is Signed In")
         
            DispatchQueue.main.async {
                self.MainController = TabBarController()
                self.MainController!.modalPresentationStyle = .fullScreen
                self.MainController!.signedOut = self
                self.present(self.MainController!, animated: true, completion: nil)
            }
         
        } else {
            print("Is Not Signed In")
            DispatchQueue.main.async {
                self.welcomeViewController = WelcomeViewController()
         
                self.welcomeViewController!.signInCompleted = self
                self.nav  = UINavigationController(rootViewController: self.welcomeViewController!)
                self.nav!.modalPresentationStyle = .fullScreen
                
                self.present(self.nav!, animated: true, completion: nil)
            }
        }
    }
}
