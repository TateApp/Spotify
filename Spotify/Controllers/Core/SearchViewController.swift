//
//  SearchViewController.swift
//  Spotify
//
//  Created by Tate Wrigley on 22/01/2022.
//

import Foundation
import UIKit
struct SearchSection {
    let title:  String
    let results : [SearchResult]
    
}
class SearchViewController : UIViewController, UISearchBarDelegate, getDataIntoPlayer_ViewController, UITextFieldDelegate, recentArtistPressed  {
    func aritstData(id: String, url: String) {
        let vc =  ArtistViewController(artistID: id, artistImageURL: url)
        vc.protocolVar = self
//        guard self.navigationController?.topViewController == self else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func passBackData(trackID: String) {
        print(trackID)
        protocolVar?.passBackData(trackID: trackID)
    }
    var protocolVar : getDataIntoPlayer_ViewController?
    var _searchText = ""
        var protocolVar_1: cancelButtonPressed?
    var searchTimer  : Timer?
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        loading.startAnimating()
        _searchText = searchText
        
        if searchText == "" {
            UIView.animate(withDuration: 0.5, animations: {
                self.vc.view.alpha = 1
                self.tableView.alpha = 0
            })
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.vc.view.alpha = 0
                self.tableView.alpha = 1
            })
        }
        searchTimer?.invalidate()
        searchTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [self] timer in
            

        let group = DispatchGroup()
        group.enter()
        
        imageCache = [String: UIImage]()
        APICaller.shared.search(search: _searchText, completion: { result in
            defer {
                group.leave()
            }
            switch result {
            case.success(let model):
                let artists = model.filter({
                    switch $0 {
                    case .artist: return true
                    default: return false
                    }
                })
                let albums = model.filter({
                    switch $0 {
                    case .album: return true
                    default: return false
                    }
                })
                let tracks = model.filter({
                    switch $0 {
                    case .track: return true
                    default: return false
                    }
                })
                let playlists = model.filter({
                    switch $0 {
                    case .playlist: return true
                    default: return false
                    }
                })
                
                self.dataModel = [
                SearchSection(title: "Artists", results: artists),
                SearchSection(title: "Albums", results: albums),
                SearchSection(title: "Tracks", results: tracks),
                SearchSection(title: "Playlists", results: playlists),
                ]
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.loading.stopAnimating()
                }
                print(self.dataModel)
                
            case.failure(let model): break
            }
        })
        })
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

       
        return false
        
    }
  
    var dataModel = [SearchSection]()
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .init(rbg: 18, green: 18, blue: 18, alpha: 1)
     
        setupSearchBar()
       
        setupTableView()
        setupRecentlySearch()
        setupLoading()
    }
    let searchbar = UISearchBar()
    let topBar = UIView()
    let cancelButton = UIButton(type: .system)
    let topBarSafeArea = UIView()
    
    func setupSearchBar() {
        self.view.addSubview(topBarSafeArea)
        topBarSafeArea.translatesAutoresizingMaskIntoConstraints = false
        topBarSafeArea.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        topBarSafeArea.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        topBarSafeArea.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        topBarSafeArea.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        topBarSafeArea.backgroundColor = .init(rbg: 26, green: 26, blue: 26, alpha: 1)
        
        self.view.addSubview(topBar)
        topBar.translatesAutoresizingMaskIntoConstraints = false
        topBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        topBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        topBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        topBar.backgroundColor = .init(rbg: 26, green: 26, blue: 26, alpha: 1)
        topBar.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        self.view.addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        cancelButton.bottomAnchor.constraint(equalTo: self.topBar.bottomAnchor).isActive = true
        cancelButton.trailingAnchor.constraint(equalTo: self.topBar.trailingAnchor, constant: -10).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonPressed(sender:)), for: .touchUpInside)
        self.view.addSubview(searchbar)
        searchbar.translatesAutoresizingMaskIntoConstraints = false
        searchbar.searchBarStyle = .minimal
        searchbar.bottomAnchor.constraint(equalTo: self.topBar.bottomAnchor).isActive = true
        searchbar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        searchbar.trailingAnchor.constraint(equalTo: self.cancelButton.leadingAnchor, constant: -10).isActive = true
        searchbar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        searchbar.searchTextField.backgroundColor = .init(rbg: 37, green: 37, blue: 37, alpha: 1)
        searchbar.placeholder = "Search"
        searchbar.tintColor = .white
        searchbar.delegate = self
        searchbar.searchTextField.textColor = .white
      
        searchbar.searchTextField.delegate = self
    }
    @objc func cancelButtonPressed(sender: UIButton) {
        protocolVar_1?.cancelButtonPressed()
        searchbar.resignFirstResponder()
    }
    
    let vc = RecentlySearchedViewController()
    func setupRecentlySearch() {
        self.addChild(vc)
        vc.protocolVar = self
        vc.didMove(toParent: self)
        self.view.addSubview(vc.view)
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        vc.view.topAnchor.constraint(equalTo: self.searchbar.bottomAnchor).isActive = true
        vc.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        vc.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        vc.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
    }
    func setupTableView() {
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: topBar.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ArtistUITableViewCell.self, forCellReuseIdentifier: ArtistUITableViewCell.Identifer)
        tableView.register(PlaylistUITableViewCell.self, forCellReuseIdentifier: PlaylistUITableViewCell.Identifer)
        tableView.register(AlbumUITableViewCell.self, forCellReuseIdentifier: AlbumUITableViewCell.Identifer)
        tableView.register(TrackUITableViewCell.self, forCellReuseIdentifier: TrackUITableViewCell.Identifer)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
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
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let result = dataModel[indexPath.section].results[indexPath.row]
        
        switch result {
        case .artist(model: let model):
            let cell = tableView.dequeueReusableCell(withIdentifier: ArtistUITableViewCell.Identifer, for: indexPath) as! ArtistUITableViewCell
            cell.backgroundColor = .clear
            cell.configure(text: model.name, subText: "", imageURL: model.images.first?.url ?? "")
            return cell
        case .track(model: let model):
            let cell = tableView.dequeueReusableCell(withIdentifier: TrackUITableViewCell.Identifer, for: indexPath) as! TrackUITableViewCell
            cell.backgroundColor = .clear
            cell.configure(text: model.name, subText:model.artists[0].name, imageURL: model.album.images.first?.url ?? "")
            return cell
        case .album(model: let model):
            let cell = tableView.dequeueReusableCell(withIdentifier: AlbumUITableViewCell.Identifer, for: indexPath) as! AlbumUITableViewCell
            cell.backgroundColor = .clear
            cell.configure(text: model.name, subText: model.artists[0].name, imageURL: model.images.first?.url ?? "")
            return cell
        case .playlist(model: let model):
            let cell = tableView.dequeueReusableCell(withIdentifier: PlaylistUITableViewCell.Identifer, for: indexPath) as! PlaylistUITableViewCell
            cell.backgroundColor = .clear
            cell.configure(text: model.name, subText: "", imageURL: model.images.first?.url ?? "")
          
            return cell
        }
   
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let result = dataModel[indexPath.section].results[indexPath.row]
        switch result {
        case .artist(model: let model):
            print(model)
            DispatchQueue.main.async {
                
                let ids = CoreDataManager.shared.fetchIDS()
                
                
                if !ids.contains(model.id) {
                    CoreDataManager.shared.appendID(id: model.id)
                }
                   
                
                self.vc.fetchData()
                
                print()
                let vc =  ArtistViewController(artistID: model.id, artistImageURL: model.images[0].url)
                vc.protocolVar = self
//                guard self.navigationController?.topViewController == self else { return }
                self.navigationController?.pushViewController(vc, animated: true)
            }
        case .track(model: let model):
          print(model)
            protocolVar?.passBackData(trackID: model.id)
        case .album(model: let model):
            APICaller.shared.getAlbum(id: model.id, completion: { done in
                switch done{
                case.success(let albumResponse):
                    DispatchQueue.main.async {
                        let vc = AlbumViewController(album: albumResponse)
                          vc.protocolVar = self
                        guard self.navigationController?.topViewController == self else { return }
                          self.navigationController?.pushViewController(vc, animated: true)
                    }
            
                case.failure(let error):
                    print(error)
                }
            })
       
        case .playlist(model: let model):
            APICaller.shared.getPlaylist(id: model.id, completion: { done in
                switch done{
                case.success(let playlistResponse):
                    DispatchQueue.main.async {
                  let vc = PlaylistViewController(playlist: playlistResponse)
                    vc.protocolVar = self
                        guard self.navigationController?.topViewController == self else { return }
                    self.navigationController?.pushViewController(vc, animated: true)
                    }
                case.failure(let error):
                    print(error)
                }
            })
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataModel[section].results.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        dataModel.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        dataModel[section].title
        
       
    }
    
    
    
    
}
