import UIKit
protocol recentArtistPressed {
    func aritstData(id: String, url: String)
}
class RecentlySearchedViewController : UIViewController , RecentlySearchTableViewCellDeletePressed{
    func deletePressed() {
       fetchData()
    }
    var protocolVar : recentArtistPressed?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(noRecentArtists)
        noRecentArtists.translatesAutoresizingMaskIntoConstraints = false
        noRecentArtists.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        noRecentArtists.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        noRecentArtists.text = "No Recent Artists"
        noRecentArtists.textColor = .white
        noRecentArtists.font = .boldSystemFont(ofSize: 20)
        setupTableView()
        fetchData()
        setupLoading()
    }
    var getArtistReponse = [GetArtistResponse]()
    let tableView = UITableView(frame: .zero, style: .plain)
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
    func fetchData() {
        loading.startAnimating()
        getArtistReponse =  [GetArtistResponse]()
        let id = CoreDataManager.shared.fetchIDS()
print(id)
        let group = DispatchGroup()
        
        if id.count > 0 {
            for index in 0...id.count - 1 {
                group.enter()
                APICaller.shared.getArtist(id: id[index], completion: { [self] result in
                    defer {
                        group.leave()
                    }
                    switch result {
                    case .success(let response):
                        var hasIt = false
                        getArtistReponse.append(response)
                    case.failure(let error):
                        print(error)
                    }
                })
            }
        } else {
            
        }
       
        
        group.notify(queue: .main) {
            self.tableView.reloadData()
            self.loading.stopAnimating()
        }
       
    }
    let noRecentArtists = UILabel()
    
    func setupTableView() {
        tableView.removeFromSuperview()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RecentlySearchTableViewCell.self, forCellReuseIdentifier: RecentlySearchTableViewCell.identifier)
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.backgroundColor = .init(rbg: 18, green: 18, blue: 18, alpha: 1)
        tableView.separatorStyle = .none
    }
    
}
extension RecentlySearchedViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecentlySearchTableViewCell.identifier, for: indexPath) as! RecentlySearchTableViewCell
        cell.protocolVar = self
        cell.configureCell(reponse: getArtistReponse[indexPath.row])
        cell.backgroundColor = .clear
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        protocolVar?.aritstData(id: getArtistReponse[indexPath.row].id, url: getArtistReponse[indexPath.row].images[0].url)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        getArtistReponse.count
    }
    
    
}
