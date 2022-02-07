import UIKit
import AVKit
protocol getDataIntoPlayerView  {
    func passBackData(trackID : String)
}
protocol getDataIntoPlayer_ViewController {
    func passBackData(trackID : String)
}
class TabBarController: UITabBarController, UIGestureRecognizerDelegate, getDataIntoPlayerView, signedOut {
    var signedOut : signedOut?
    func _signedOut() {
    
        signedOut?._signedOut()
    
    }
    
   
    func passBackData(trackID: String) {
       
        APICaller.shared.getTrackInfo(id: trackID, completion: { result in
            switch  result {
            case .success(let model):
                print(model)
                DispatchQueue.main.async {
                    self.playerViewController.loadData(track: model)
                    self.currentlyPlaying.loadData(track: model)
                    self.currentlyPlaying.visibleMode()
                }
               
        
            case .failure(let error):
                print(error)
            }
        })
    }
    var tabBarView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
       
        setupViewControllers()
  

   
    }
   
    func setupViewControllers() {
        
         
              
              let homeViewController = HomeViewController()
              homeViewController.title  = "Home"
              homeViewController.protocolVar = self
        homeViewController.signedOut = self
              let navHomeViewController = UINavigationController(rootViewController: homeViewController)
              navHomeViewController.isNavigationBarHidden = true
              
              let categorieViewController = CategoryViewController()
              categorieViewController.title  = "Search"
              categorieViewController.protocolVar = self
              
              let navCategorieViewController = UINavigationController(rootViewController: categorieViewController)
              navCategorieViewController.isNavigationBarHidden = true
              
              let yourLibraryViewController = YourLibraryViewController()
              yourLibraryViewController.title  = "Library"
           
              let navYourLibraryViewController = UINavigationController(rootViewController: yourLibraryViewController)
              navYourLibraryViewController.isNavigationBarHidden = true
              
             self.viewControllers = [
                  navHomeViewController,
                  navCategorieViewController,
                  navYourLibraryViewController,
                  
              ]
              let inset : CGFloat = 12
              
              self.viewControllers![0].tabBarItem.image = UIImage(imageLiteralResourceName: "Home_Unselected").withRenderingMode(.alwaysOriginal)
              self.viewControllers![0].tabBarItem.selectedImage = UIImage(imageLiteralResourceName: "Home_Selected").withRenderingMode(.alwaysOriginal)
              self.viewControllers![0].tabBarItem.imageInsets = UIEdgeInsets(top: inset, left:inset, bottom:inset, right: inset)
              
              self.viewControllers![1].tabBarItem.image = UIImage(imageLiteralResourceName: "Search_Unselected").withRenderingMode(.alwaysOriginal)
              self.viewControllers![1].tabBarItem.selectedImage = UIImage(imageLiteralResourceName: "Search_Selected").withRenderingMode(.alwaysOriginal)
              self.viewControllers![1].tabBarItem.imageInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
              
              
              self.viewControllers![2].tabBarItem.image = UIImage(imageLiteralResourceName: "Library_Unselected").withRenderingMode(.alwaysOriginal)
              self.viewControllers![2].tabBarItem.selectedImage = UIImage(imageLiteralResourceName: "Library_Selected").withRenderingMode(.alwaysOriginal)
              self.viewControllers![2].tabBarItem.imageInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
              
              
             
              self.tabBar.tintColor = .systemGray6
              self.tabBar.backgroundColor = .init(rbg: 18, green: 18, blue: 18, alpha: 1)
              self.tabBar.backgroundImage = UIImage().withTintColor(.init(rbg: 18, green: 18, blue: 18, alpha: 1))
              
              self.selectedIndex = 0

              
      setupCurrentlyPlaying()
      setupPlayerViewController()
      getData()
    }
    let currentlyPlaying = currentlyPlayingView()
    
    var currentPlayingHeightAnchor_InActive = NSLayoutConstraint()
    
    var currentPlayingHeightAnchor_Active = NSLayoutConstraint()
    
    func setupCurrentlyPlaying() {
        self.view.addSubview(currentlyPlaying)
        currentlyPlaying.translatesAutoresizingMaskIntoConstraints = false
        currentlyPlaying.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 20).isActive = true
        currentPlayingHeightAnchor_InActive = currentlyPlaying.heightAnchor.constraint(equalToConstant: 60)
        currentPlayingHeightAnchor_InActive.isActive = true
        
        currentPlayingHeightAnchor_Active = currentlyPlaying.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height)
        currentPlayingHeightAnchor_Active.isActive = false
        currentlyPlaying.backgroundColor = .blue
        currentlyPlaying.bottomAnchor.constraint(equalTo: self.tabBar.topAnchor).isActive = true
        currentlyPlaying.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        currentlyPlaying.gestureRecognizers = [
            panGesture
            ]
        currentlyPlaying.backgroundColor = UIColor.init(rbg: 30, green: 30, blue: 30, alpha: 1)
        currentlyPlaying.layer.cornerRadius = 10
        currentlyPlaying.tag = 1
        currentlyPlaying.invisibleMode()
        currentlyPlaying.layer.shadowRadius = 10
        currentlyPlaying.layer.shadowOpacity = 0.5
        currentlyPlaying.layer.shadowOffset = .zero
    }
    let playerViewController = PlayerViewController()
    let panGesture = UIPanGestureRecognizer()
    let loadedDragView = UIView()
    func setupPlayerViewController() {
       
        panGesture.delegate = self
        panGesture.addTarget(self, action: #selector(pangGesture(sender:)))
        self.view.addSubview(playerViewController.view)
        self.addChild(playerViewController)
        playerViewController.didMove(toParent: self)
        self.playerViewController.view.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.playerViewController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.playerViewController.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.playerViewController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.playerViewController.view.transform = .init(translationX: 0, y: UIScreen.main.bounds.height)
        self.playerViewController.view.alpha = 0
        
        
    }
    func getData() {
        APICaller.shared.getCurrentPlayingTrack(completion: { result in
            switch result {
            case (.success(let model)):
                DispatchQueue.main.async {
                    self.currentlyPlaying.loadData(track: model.item)
                    self.currentlyPlaying.visibleMode()
                    self.playerViewController.loadData(track: model.item)
                }
             
            case (.failure(let error)):
                DispatchQueue.main.async {
                print("Failed to get Data")
                }
            }
        })
    }
    var stateAchieved = false
    var done = false
    @objc func pangGesture(sender: UIPanGestureRecognizer) {
        print("Pan Detected")
        print(stateAchieved)
        let translation = sender.translation(in: self.view)
        print(translation.y)
        print(sender.view!.tag)
        if currentlyPlaying.hasDataIn == true {
            if sender.state == .began{
                currentlyPlaying.invisibleMode()
                self.playerViewController.view.alpha = 1
            }
            if sender.state == .changed{
                if translation.y >  0 - (UIScreen.main.bounds.height / 3) {
                stateAchieved = false
                } else {
                    stateAchieved = true
                }
                if done == false {
                    self.playerViewController.view.transform = .init(translationX: 0, y: (UIScreen.main.bounds.height - 100) + translation.y)
                } else if done == true {
                    self.playerViewController.view.transform = .init(translationX: 0, y:  translation.y)
                }
                
             
            }
            if sender.state == .ended{
                if stateAchieved == false {
                    self.currentlyPlaying.transform = .identity
                    UIView.animate(withDuration: 0.5, animations: {
                        self.playerViewController.view.transform = .init(translationX: 0, y: UIScreen.main.bounds.height)
                        self.currentlyPlaying.largeMode = false
                        self.playerViewController.view.alpha = 0
                        self.loadedDragView.alpha = 0
                        self.currentPlayingHeightAnchor_Active.isActive = false
                        self.currentPlayingHeightAnchor_InActive.isActive = true
                        self.currentlyPlaying.visibleMode()
                    })
                    done = false
                } else {
                    UIView.animate(withDuration: 0.5, animations: {
                    self.playerViewController.view.transform = .identity
                    self.playerViewController.view.alpha = 1
                        self.view.bringSubviewToFront(self.currentlyPlaying)
                        self.currentlyPlaying.transform = .identity
                        self.currentlyPlaying.largeMode = true
                        
                        self.currentlyPlaying.invisibleMode()
                        self.currentPlayingHeightAnchor_Active.isActive = true
                        self.currentPlayingHeightAnchor_InActive.isActive = false
                    })
                    done = true
                }
            }
        }
    
    }
    
}
class currentlyPlayingView: UIView {
    

   
    var largeMode = false
    let imageView = CustomImageView()
    let text = UILabel()
var hasDataIn = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.layer.borderWidth = 1
//        self.layer.borderColor = UIColor.white.cgColor
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true

        imageView.contentMode = .scaleAspectFill
        
        self.addSubview(text)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.topAnchor.constraint(equalTo: self.imageView.topAnchor).isActive = true
        text.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor,constant: 10).isActive = true
        text.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        text.bottomAnchor.constraint(equalTo: self.imageView.bottomAnchor).isActive = true
        text.textAlignment = .left
        text.textColor = .white
        text.font = .boldSystemFont(ofSize: 12)
        text.numberOfLines = .max
        
      
    }
    
    
    func invisibleMode() {
        UIView.animate(withDuration: 0.1, animations: {
            self.backgroundColor = .clear
        self.imageView.alpha = 0
            self.text.alpha = 0
        })
    }
    func visibleMode() {
        UIView.animate(withDuration: 0.1, animations: {
            self.backgroundColor = UIColor.init(rbg: 30, green: 30, blue: 30, alpha: 1)
        self.imageView.alpha = 1
            self.text.alpha = 1
        })
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var _track : AudioTrack?
    func loadData(track: AudioTrack) {
        _track  = track
        hasDataIn = true
        imageView.loadImage(with: track.album.images[0].url)
text.text =
"""
\(track.name)
\(track.album.artists[0].name)
"""
        self.layoutSubviews()
    }
    override func layoutSubviews() {
        if  imageView.image != nil {
//            self.backgroundColor = imageView.image!.averageColor.!
        }
        
    }
}
