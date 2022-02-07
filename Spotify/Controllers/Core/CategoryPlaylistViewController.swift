import UIKit

class CategoryPlaylistViewController: UIViewController, getDataIntoPlayer_ViewController {
    func passBackData(trackID: String) {
        protocolVar?.passBackData(trackID: trackID)
    }
    var protocolVar: getDataIntoPlayer_ViewController?
    
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    var _response : CategoryPlaylistResponse?
    var _responseTitle: String?
    init(response : CategoryPlaylistResponse, responseTitle: String) {
        super.init(nibName: nil, bundle: nil)
         _response = response
        _responseTitle = responseTitle
         print(_response?.playlists.items.count)
     
    }
   
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setupCollectionView()
        
        
        
        setupTitles()
        
        setuphiddenNavBar()
        
   
    }
    let hiddenNavBar = UIView()
    let hiddenTitle = UILabel()
    let hiddenNavBarSafeAreaGuide = UIView()
    func setuphiddenNavBar() {
        self.view.addSubview(hiddenNavBarSafeAreaGuide)
        hiddenNavBarSafeAreaGuide.translatesAutoresizingMaskIntoConstraints = false
        hiddenNavBarSafeAreaGuide.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        hiddenNavBarSafeAreaGuide.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        hiddenNavBarSafeAreaGuide.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        hiddenNavBarSafeAreaGuide.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        hiddenNavBarSafeAreaGuide.alpha = 0
        hiddenNavBarSafeAreaGuide.backgroundColor = .blue
        self.view.addSubview(hiddenNavBar)
        hiddenNavBar.translatesAutoresizingMaskIntoConstraints = false
        hiddenNavBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        hiddenNavBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        hiddenNavBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        hiddenNavBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        hiddenNavBar.backgroundColor = .blue
        hiddenNavBar.alpha = 0
        
        self.view.addSubview(hiddenTitle)
        hiddenTitle.translatesAutoresizingMaskIntoConstraints = false
        hiddenTitle.bottomAnchor.constraint(equalTo: self.hiddenNavBar.bottomAnchor, constant: -20).isActive = true
        hiddenTitle.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        hiddenTitle.text = _responseTitle
        hiddenTitle.font = .boldSystemFont(ofSize: 15)
        hiddenTitle.textColor = .white
        hiddenTitle.alpha = 0
        
        self.view.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        backButton.centerYAnchor.constraint(equalTo: self.hiddenTitle.centerYAnchor).isActive = true
        backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        backButton.setTitle("<", for: .normal)
        backButton.addTarget(self, action: #selector(backButtonPressed(sender:)), for: .touchUpInside)
        backButton.setTitleColor(.white, for: .normal)
        backButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
    }
    @objc func backButtonPressed(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    var viewDidLayoutSubviewsDone = false
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewDidLayoutSubviewsDone = true
    }
    let largeTitle = UILabel()
    let subTitle = UILabel()
    let backButton = UIButton(type: .system)
    func setupTitles() {
        self.view.addSubview(largeTitle)
        largeTitle.translatesAutoresizingMaskIntoConstraints = false
        largeTitle.topAnchor.constraint(equalTo: self.collectionView.topAnchor, constant: -100).isActive = true
        largeTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        largeTitle.text = _responseTitle
        largeTitle.font = .boldSystemFont(ofSize: 25)
        largeTitle.textColor = .white
        self.view.addSubview(subTitle)
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        subTitle.topAnchor.constraint(equalTo: largeTitle.bottomAnchor, constant: 30).isActive = true
        subTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        subTitle.text = "Popular Playlist"
        subTitle.font = .boldSystemFont(ofSize: 15)
        subTitle.textColor = .white
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 20
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.contentInset = .init(top: 150, left: 20, bottom: 20, right: 20)
        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionView.backgroundColor = .init(rbg: 18, green: 18, blue: 18, alpha: 1)
        collectionView.register(CategoryPlaylistCell.self, forCellWithReuseIdentifier: CategoryPlaylistCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
      
    }
    
    
}
extension CategoryPlaylistViewController : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        _response!.playlists.items.count
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        if viewDidLayoutSubviewsDone == true {
            
    
        if scrollView.contentOffset.y > -115 {
            UIView.animate(withDuration: 0.5, animations: {
                self.hiddenNavBar.alpha = 1
                self.hiddenTitle.alpha = 1
                self.hiddenNavBarSafeAreaGuide.alpha = 1
            })
         
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.hiddenNavBar.alpha = 0
                self.hiddenTitle.alpha = 0
                self.hiddenNavBarSafeAreaGuide.alpha = 0
            })
        }
        }
        largeTitle.transform = .init(translationX: 0, y: 0 - scrollView.contentOffset.y)
        subTitle.transform = .init(translationX: 0, y: 0 - scrollView.contentOffset.y)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width / 2) - 40 , height: (UIScreen.main.bounds.width / 2) )
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryPlaylistCell.identifier, for: indexPath) as! CategoryPlaylistCell
        cell.configure(response: (_response?.playlists.items[indexPath.row])!)
 
        return cell
    }
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        APICaller.shared.getPlaylist(id: (_response?.playlists.items[indexPath.row].id)!, completion: { result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    let vc = PlaylistViewController(playlist: model)
                    vc.protocolVar = self
                    guard self.navigationController?.topViewController == self else { return }
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            
            case .failure(let error):
                
                print(error)
//                print(error)
            }
            
        })
    }
    
    
    
    
}
