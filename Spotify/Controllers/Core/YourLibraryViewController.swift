import UIKit

class YourLibraryViewController : UIViewController, getDataIntoPlayer_ViewController {
    func passBackData(trackID: String) {
        protocolVar?.passBackData(trackID: trackID)
    }
    var protocolVar : getDataIntoPlayerView?
    
    
    let yourLibraryLabel = UILabel()
    let topBar = UIView()
    let userProfileImage = CustomImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .init(rbg: 18, green: 18, blue: 18, alpha: 1)
        fetchData()
        setupTopBar()
        setupTableView()
        setupLoading()
    }
    let loading = UIActivityIndicatorView()
    func setupLoading() {
        self.view.addSubview(loading)
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        loading.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        loading.widthAnchor.constraint(equalToConstant: 100).isActive = true
        loading.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        loading.color =  .white
    
    }
    var myResponse : MyPlaylistResponse?
    func fetchData() {
        loading.startAnimating()
        let group = DispatchGroup()
        group.enter()
        group.enter()
        APICaller.shared.getCurrentUserProfile(completion: { result in
            defer {
                group.leave()
            }
            switch result  {
                
            case .success(let profile):
                DispatchQueue.main.async {
                    self.userProfileImage.loadImage(with:  profile.images.first?.url ?? "" )
                }
               
            case .failure(let error):
                print(error)
            }
            
        })
        APICaller.shared.getMyPlaylists(completion: { result in
            defer {
                group.leave()
            }
            switch result {
            case .success(let response):
                self.myResponse = response
            case .failure(let error):
                print(error)
            }
        })
        
        group.notify(queue: .main) {
            self.tableView.reloadData()
            self.setupTableView()
            self.loading.stopAnimating()
        }
       
    }
    func setupTopBar() {
        self.view.addSubview(topBar)
        topBar.translatesAutoresizingMaskIntoConstraints = false
        topBar.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        topBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        topBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        topBar.heightAnchor.constraint(equalToConstant: 100).isActive = true
        topBar.layer.shadowOpacity = 0.5
        topBar.layer.shadowOffset = .zero
        topBar.layer.shadowRadius = 10
        topBar.backgroundColor =  .init(rbg: 18, green: 18, blue: 18, alpha: 1)
        
        self.view.addSubview(userProfileImage)
        userProfileImage.translatesAutoresizingMaskIntoConstraints = false
        userProfileImage.topAnchor.constraint(equalTo: self.topBar.topAnchor, constant: 50).isActive = true
        userProfileImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        userProfileImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        userProfileImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        userProfileImage.layer.cornerRadius = 15
        userProfileImage.layer.masksToBounds = true
        
        self.view.addSubview(yourLibraryLabel)
        
        yourLibraryLabel.translatesAutoresizingMaskIntoConstraints = false
        yourLibraryLabel.topAnchor.constraint(equalTo: self.topBar.topAnchor, constant: 50).isActive = true
        yourLibraryLabel.leadingAnchor.constraint(equalTo: self.userProfileImage.trailingAnchor, constant: 10).isActive = true
        yourLibraryLabel.text = "Your Library"
        yourLibraryLabel.font = .boldSystemFont(ofSize: 20)
        yourLibraryLabel.textColor = .white
    }
    let tableView = UITableView(frame: .zero, style: .plain)
    
    func setupTableView() {
        
        self.view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.topBar.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.register(YourLibraryUITableViewCell.self, forCellReuseIdentifier: YourLibraryUITableViewCell.identifer)
        tableView.separatorStyle = .none
     
        self.view.bringSubviewToFront(topBar)
        self.view.bringSubviewToFront(userProfileImage)
        self.view.bringSubviewToFront(yourLibraryLabel)
    }
    
}
extension YourLibraryViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: YourLibraryUITableViewCell.identifer, for: indexPath) as! YourLibraryUITableViewCell
        cell.configureCell(myResponseItem:  myResponse!.items[indexPath.row])
        cell.backgroundColor = .clear
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        APICaller.shared.getPlaylist(id:  myResponse!.items[indexPath.row].id, completion: { result in
            
            switch result {
                
            case .success(let reponse):
                DispatchQueue.main.async {
                    let vc = PlaylistViewController(playlist: reponse)
                    vc.protocolVar = self
                    guard self.navigationController?.topViewController == self else { return }
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
            case .failure(let error):
                print(error)
            }
            
        })
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if myResponse != nil {
            return myResponse!.items.count
        } else {
            return 0
        }
      
    }
    
    
}
