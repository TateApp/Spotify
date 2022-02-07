import UIKit
import AVKit
enum BrowseSelectionType {
    case recentlyPlayedFirst(sectionTitle: String,viewModel: [RecentlyPlayedFirstCellModel])
    case newRelease(sectionTitle: String,viewModel: [NewReleaseCellViewModel])
    case featuredPlaylist(sectionTitle: String, viewModel: [FeaturedPlaylistCellViewModel])
    case reccomendedTracks(sectionTitle: String, viewModel: [ReccomendedTrackCellViewModel])
    case recentlyPlayed(sectionTitle: String, viewModel: [RecentlyPlayedCellViewModel])
    case myPlaylists(sectionTitle: String, viewModel: [MyPlaylistsCellViewModel])
}
protocol signedOut {
    func _signedOut()
}
class HomeViewController: UIViewController, getDataIntoPlayer_ViewController, signOutPressed {
    var signedOut: signedOut?
    func _signedOut() {
        signedOut!._signedOut()
    }
    func signOutPressed() {
        let alertController = UIAlertController(title: "Log Out", message: "Are you sure you want to log out", preferredStyle: .alert)
       
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            
        }))
        alertController.addAction(UIAlertAction(title: "Sign out", style: .default, handler: { action in
            AuthManager.shared.signOut(completion: { done in
                if done {
                    DispatchQueue.main.async {
                        print("Signed out complete")
                        self._signedOut()
                    }
                }
            })
 
           
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func passBackData(trackID: String) {
        protocolVar?.passBackData(trackID: trackID)
    }
    var protocolVar : getDataIntoPlayerView?
    var sections = [BrowseSelectionType]()
    
    var collectionView  = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
        return  HomeViewController.createSectionLayout(section: sectionIndex)
     })
    
    
    
    var tempSettingButton = UIButton()

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.view.backgroundColor = .init(rbg: 18, green: 18, blue: 18, alpha: 1)

        setupGradient()
        
       
fetchData()
        
configureCollectionView()

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
    func configureCollectionView() {
       
        self.view.addSubview(collectionView)
        //MARK: - First Cell Header
        collectionView.register(HeaderClassTop.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerTop")
        //MARK: - Normal Header
        collectionView.register(HeaderClass.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        //MARK: - First Cell
        collectionView.register(RecentlyPlayedFirstCell.self, forCellWithReuseIdentifier: RecentlyPlayedFirstCell.identifier)
        //MARK: - RecentlyPlayedCell
        collectionView.register(RecentlyPlayedCell.self, forCellWithReuseIdentifier: RecentlyPlayedCell.identifier)
        //MARK: - NewRelease
        collectionView.register(NewReleaseCollectionViewCell.self, forCellWithReuseIdentifier: NewReleaseCollectionViewCell.identifier)
        //MARK: - FeaturedPlaylistCollectionViewCell
        collectionView.register(FeaturedPlaylistCollectionViewCell.self, forCellWithReuseIdentifier: FeaturedPlaylistCollectionViewCell.identifier)
        //MARK: - RecommendedTrackCollectionViewCell
        collectionView.register(RecommendedTrackCollectionViewCell.self, forCellWithReuseIdentifier: RecommendedTrackCollectionViewCell.identifier)
        //MARK: - MyPlaylistCell
        collectionView.register(MyPlaylistCell.self, forCellWithReuseIdentifier: MyPlaylistCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView .backgroundColor = .clear
    }
    private static func createSectionLayout(section: Int) -> NSCollectionLayoutSection {
        switch section {
            //MARK: - Recently Played
        case 0:
            //Item
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1)))
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            //Group
            //Vertical group in Horizontal Grup
            let Vgroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(60)),
                                                         subitem: item,
                                                         count: 2)
            Vgroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
//            let Hgroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(
//                widthDimension: .fractionalWidth(0.9),
//                heightDimension: .absolute(390)),
//                                                         subitem: Vgroup,
//                                                         count: 1)
            //Section
        

            let section = NSCollectionLayoutSection(group: Vgroup)
            
            let footerHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                    heightDimension: .absolute(50.0))
                      let header = NSCollectionLayoutBoundarySupplementaryItem(
                          layoutSize: footerHeaderSize,
                          elementKind: UICollectionView.elementKindSectionHeader,
                          alignment: .top)
            section.boundarySupplementaryItems = [header]

            return section
        
        default:
            //Item
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(150),
                heightDimension: .absolute(150)))
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            //Group
            //Vertical group in Horizontal Grup
            let Hgroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(UIScreen.main.bounds.width),
                heightDimension: .absolute(150)),
                                                         subitem: item,
                                                         count: 3)
           
            //Section
            
            let section = NSCollectionLayoutSection(group: Hgroup)
            let footerHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                    heightDimension: .absolute(50.0))
                      let header = NSCollectionLayoutBoundarySupplementaryItem(
                          layoutSize: footerHeaderSize,
                          elementKind: UICollectionView.elementKindSectionHeader,
                          alignment: .top)

                      section.boundarySupplementaryItems = [header]
            section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
            return section
        }
       
    }
    var categories = [
        "toplists",
        "pop",
        "workout",
        "mood",
        "hiphop",
        "party",
//        "edm_dance",
        "frequency",
        "alternative",
//        "equal",
//        "at_home",
//        "netflix",
//        "indie_alt",
//        "pride",
//        "wellness",
//        "rock",
//        "throwback",
//        "radar",
//        "rnb",
//        "chill",
//        "kids_family",
//        "gaming",
//        "sleep",
//        "in_the_car",
//        "caribbean",
//        "classical",
//        "sessions",
//        "romance",
//        "jazz",
//        "popculture",
//        "student",
//        "desi",
//        "instrumental",
//        "afro",
//        "country",
//        "ambient",
//        "focus",
//        "metal",
//        "soul",
//        "thirdparty",
//        "roots",
//        "arab",
//        "punk",
//        "dinner",
//        "kpop",
//        "blues",
//        "travel",
//        "latin",
//        "funk",
   
    
    ]
    let gradient = Gradient(frame: .zero, gradientColor: [UIColor.lightGray.cgColor, UIColor.init(rbg: 18, green: 18, blue: 18, alpha: 1).cgColor], location: [0.0,1.0]  , type: .radial, startPoint: .init(x: 0.5, y: 0.5), endPoint: .init(x: 1.0, y: 1.0))
    func setupGradient () {
        self.view.addSubview(gradient)
        gradient.translatesAutoresizingMaskIntoConstraints = false
        gradient.centerYAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        gradient.centerXAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        gradient.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 2).isActive = true
        gradient.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        gradient.alpha = 0
    }
    func fetchData() {
        loading.startAnimating()
print("Fetch Data Launched")
        let group = DispatchGroup()
       
        group.enter()
        group.enter()
        group.enter()
        group.enter()
        group.enter()
        group.enter()
     
        
        var newReleases : NewReleaseResponse?
        var featuredPlaylists: FeaturedPlaylistResponse?
        var myPlaylists: MyPlaylistResponse?
        var recommendations: ReccomendationsResponse?
        var recentlyPlayed: RecentlyPlayedResonse?
        var recentlyPlayed_3: RecentlyPlayedResonse?
        var particularPlaylistReponse = [FeaturedPlaylistResponse]()
        

        for index in 0...categories.count - 1 {
            group.enter()
            APICaller.shared.getParticularPlaylist(category: categories[index], completion: { result in
                defer {
                    group.leave()
                }
                switch result {
                case.success(let model):
                

                    particularPlaylistReponse.append(model)
                   
                case.failure(let error):
                    print("Profile Error: \(error.localizedDescription)")
                 
                }
            })
            
        }
        APICaller.shared.getNewReleases(completion: { result in
            switch result {
            case.success(let model):
               
           newReleases = model
            case.failure(let error):
                print("Profile Error: \(error.localizedDescription)")
             
            }
        })
        APICaller.shared.getRecentlyPlayed(limit: 6,completion: { result in
            defer {
                group.leave()
            }
          
            switch result {
            case.success(let model):
                print("Gets here 5")
                recentlyPlayed = model
            case.failure(let error):
                print("Profile Error: \(error.localizedDescription)")
             
            }
        })
        //MARK: - New Releases
        APICaller.shared.getNewReleases(completion: { result in
            defer {
                group.leave()
            }
            switch result {
            case .success(let model):
                
                newReleases = model
                print("Gets here 1")
                break
            case.failure(let error): break
             
            }
            
        })
//MARK: - Featured Playlists,
        APICaller.shared.getFeaturedPlaylists(completion: { result in
            defer {
                group.leave()
            }
//            print(result)
            switch result {
            case .success(let model):
                featuredPlaylists = model
                print("Gets here 2")
                break
            case.failure(let error): break
             
            }
            
        })
        //MARK: - Reccomended Tracks,
        APICaller.shared.getRecommendedGenres(completion: { result in
           
            switch result {
            case .success(let model_1):
                
                let genres = model_1.genres
                var seeds = Set<String>()
                while seeds.count < 5 {
                    if let random  = genres .randomElement() {
                        seeds.insert(random)
                    }
                 
                }
                APICaller.shared.getRecommendations(genres: seeds, completion: { result in
                    defer {
                        group.leave()
                    }
                                switch result {
                                case .success(let model_2):
                              print("Gets Here 3")
                                    recommendations = model_2
                                   break
                                case .failure(let error):  break
                                    print(error)
                                }
                })
                break
            case .failure(let error):
                print(error)
            }
        })
        APICaller.shared.getRecentlyPlayed(limit: 20,completion: { result in
            defer {
                group.leave()
            }
          
            switch result {
            case.success(let model):
             print("Got here 4")
                recentlyPlayed_3 = model
            case.failure(let error):
                print("Profile Error: \(error.localizedDescription)")
             
            }
        })
        
        APICaller.shared.getCurrentUserProfile(completion: { result in
            defer {
                group.leave()
            }
            switch result {
            case.success(let model):
             print("Got here 5")
                APICaller.shared.getMyPlaylist(name: model.display_name, limit: 1, completion: { result in
                    print("Got here 6")
                    switch result {
                    case.success(let model):
                     print("Got here 7")
                        myPlaylists = model
                    case.failure(let error):
                        print("Profile Error: \(error.localizedDescription)")
                     
                    }
               
                    
                })
            case.failure(let error):
                print("Profile Error: \(error.localizedDescription)")
             
            }
        })
      
        group.notify(queue: .main) {
            //Configure Model
            guard let recentlyPlayed = recentlyPlayed?.items,
                  let recentlyPlayed_3 = recentlyPlayed_3?.items,
            let newAlbums = newReleases?.albums.items,
              let playlists = featuredPlaylists?.playlists.items,
                  let myPlaylists = myPlaylists?.items,
//                  let particularPlaylists  = particularPlaylistReponse,
              let tracks  = recommendations?.tracks else {
                  
                  print("API Failure")
                  self.gotHere()
                  return
              
              }
           
            
     print("Configuring view Models")
           
            self.loading.stopAnimating()
            self.configureModel(recentlyPlayed: recentlyPlayed, recentlyPlayed_3: recentlyPlayed_3, newAlbums: newAlbums, playlist: playlists, tracks: tracks, myPlaylists: myPlaylists, particularPlaylists: particularPlaylistReponse)
        }
      
    
    }
    func gotHere() {
        print("Got Here Due to Failure")
        self.fetchData()
    }
    func configureModel(recentlyPlayed: [RecentlyPlayedItem] , recentlyPlayed_3: [RecentlyPlayedItem], newAlbums: [Album], playlist: [Playlist], tracks : [AudioTrack], myPlaylists: [MyPlaylistItem], particularPlaylists: [FeaturedPlaylistResponse]) {
//        UIView.animate(withDuration: 0.25, animations: {
            self.gradient.alpha = 0.3
//        })
       
        print("Model Configured")
        print(myPlaylists.count)
        print(recentlyPlayed.count)
        print(recentlyPlayed_3.count)
        print(newAlbums.count)
        print(playlist.count)
        print("particularPlaylists Count")
        print(particularPlaylists.count)
//        for index in 0...tracks.count - 1 {
//            print(tracks[index])
//        }
   
     
        sections.append(.recentlyPlayedFirst(sectionTitle: "Good Morning", viewModel: recentlyPlayed.compactMap({
            return RecentlyPlayedFirstCellModel(albumName: $0.track.album.name, artworkURL: URL(string: $0.track.album.images.first?.url ?? "") ,
                                           numberOfTracks: $0.track.album.total_tracks,
                                                artistName: $0.track.album.artists.first?.name ?? "", trackName: $0.track.name, id: $0.track.id)
        })))
        sections.append(.newRelease(sectionTitle: "New Release Albums", viewModel: newAlbums.compactMap({
            return NewReleaseCellViewModel(albumName: $0.name, artworkURL: URL(string: $0.images.first?.url ?? ""), numberOfTracks: $0.total_tracks, artistName: $0.artists.first!.name, trackName: "", id: $0.id)
        })))
        sections.append(.featuredPlaylist(sectionTitle: "Featured Playlists", viewModel: playlist.compactMap({
            return FeaturedPlaylistCellViewModel(albumName: $0.name, artworkURL: URL(string: $0.images.first?.url ?? "") ,
                                           numberOfTracks: 0,
                                                 artistName:  "", trackName: "", id: $0.id)
        })))
        sections.append(.reccomendedTracks(sectionTitle: "Reccomended Tracks", viewModel: tracks.compactMap({
            return ReccomendedTrackCellViewModel(albumName: $0.album.name, artworkURL: URL(string: $0.album.images.first?.url ?? "") ,
                                           numberOfTracks: $0.album.total_tracks,
                                                 artistName: $0.artists.first?.name ?? "", trackName: $0.name, id: $0.id)
        })))
        sections.append(.recentlyPlayed(sectionTitle: "Recently Played", viewModel: recentlyPlayed_3.compactMap({
            return RecentlyPlayedCellViewModel(albumName: $0.track.album.name, artworkURL: URL(string: $0.track.album.images.first?.url ?? "") ,
                                           numberOfTracks: $0.track.album.total_tracks,
                                               artistName: $0.track.album.artists.first?.name ?? "", trackName: $0.track.name, id: $0.track.id)
        })))
//        sections.append(.myPlaylists(sectionTitle: "My Playlists", viewModel: myPlaylists.compactMap({
//            return MyPlaylistsCellViewModel(albumName: $0.name, artworkURL: URL(string: $0.images.first?.url ?? "") ,
//                                           numberOfTracks: $0.tracks.total,
//                                            artistName:  "", trackName: "",id: $0.id)
//        })))
        for index in 0...particularPlaylists.count - 1 {
            sections.append(.featuredPlaylist(sectionTitle: "\(categories[index].uppercased()) Playlist", viewModel: particularPlaylists[index].playlists.items.compactMap({
                return FeaturedPlaylistCellViewModel(albumName: $0.name, artworkURL: URL(string: $0.images.first?.url ?? "") ,
                                               numberOfTracks: 0,
                                               artistName:  "", trackName: "" ,id: $0.id)
            })))
        }
//        print("Section\(sections)")
        
        collectionView.reloadData()
       
        
    }
    func setup_tempSettingButton() {
        self.view.addSubview(tempSettingButton)
        tempSettingButton.translatesAutoresizingMaskIntoConstraints = false
        tempSettingButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true
        tempSettingButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        tempSettingButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        tempSettingButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        tempSettingButton.backgroundColor = .blue
        tempSettingButton.addTarget(self, action: #selector(tempSettingButtonPressed(sender:)), for: .touchUpInside)
    }
    @objc func tempSettingButtonPressed(sender: UIButton) {
        let vc = SettingsViewCotroller()
        guard self.navigationController?.topViewController == self else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = self.view.bounds
      
    }
}

extension HomeViewController : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        if scrollView.contentOffset.y > 200 {
            UIView.animate(withDuration: 0.5, animations: {
                self.gradient.alpha = 0
            })
            
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.gradient.alpha = 0.3
            })
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let type = sections[indexPath.section]
        switch type {
        case.recentlyPlayedFirst(viewModel: let viewModel):
            print("recentlyPlayedFirst Pressed")
            print(viewModel.viewModel[indexPath.section].id)
            protocolVar?.passBackData(trackID: viewModel.viewModel[indexPath.row].id)
        case.newRelease(viewModel: let viewModel):
            APICaller.shared.getAlbum(id: viewModel.viewModel[indexPath.row].id, completion: { result in
                switch result {
                case.success(let model):
                    DispatchQueue.main.async {
                        let vc =  AlbumViewController(album: model)
                        vc.protocolVar = self
                        guard self.navigationController?.topViewController == self else { return }
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                 
                case.failure(let error):
                    print("Profile Error: \(error.localizedDescription)")
                 
                }
            })
            print(viewModel.viewModel[indexPath.section].id)
            
        case .featuredPlaylist(viewModel: let viewModel):
            print("featuredPlaylist Pressed")
//            print(viewModel.viewModel[indexPath.section].id)
            APICaller.shared.getPlaylist(id: viewModel.viewModel[indexPath.row].id, completion: { result in
                switch result {
                case.success(let model):
                    DispatchQueue.main.async {
                        let vc =  PlaylistViewController(playlist : model)
                        vc.protocolVar = self
                        guard self.navigationController?.topViewController == self else { return }
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                 
                case.failure(let error):
                    print("Profile Error: \(error.localizedDescription)")
                 
                }
            })
        case .reccomendedTracks(viewModel: let viewModel):
            print("reccomendedTracks Pressed")
            protocolVar?.passBackData(trackID: viewModel.viewModel[indexPath.row].id)
            print(viewModel.viewModel[indexPath.section].id)
            
        case .recentlyPlayed(viewModel: let viewModel):
            print("recentlyPlayed Pressed")
            print( viewModel.viewModel[indexPath.row].trackName!)
            protocolVar?.passBackData(trackID: viewModel.viewModel[indexPath.row].id)
        
//            print(viewModel.viewModel[indexPath.section].id)
            
          
            
        case .myPlaylists(viewModel: let viewModel):
            print("myPlaylists Pressed")
            APICaller.shared.getPlaylist(id: viewModel.viewModel[indexPath.row].id, completion: { result in
            switch result {
            case.success(let model):
                DispatchQueue.main.async {
                    let vc =  PlaylistViewController(playlist : model)
                    vc.protocolVar = self
                    guard self.navigationController?.topViewController == self else { return }
                    self.navigationController?.pushViewController(vc, animated: true)
                }
             
            case.failure(let error):
                print("Profile Error: \(error.localizedDescription)")
             
            }
            })
        }
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            if indexPath.section != 0 {
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: "header", for: indexPath) as! HeaderClass
                let type = sections[indexPath.section]
               
                
                switch type {
                case.recentlyPlayedFirst(viewModel: let viewModel):
                    headerView.configure(sectionHeader: viewModel.sectionTitle)
                case .newRelease(viewModel: let viewModel):
                    headerView.configure(sectionHeader: viewModel.sectionTitle)
                case .featuredPlaylist(viewModel: let viewModel):
                    headerView.configure(sectionHeader: viewModel.sectionTitle)
                case .reccomendedTracks(viewModel: let viewModel):

                    headerView.configure(sectionHeader: viewModel.sectionTitle)
                    
                case .recentlyPlayed(viewModel: let viewModel):

                    headerView.configure(sectionHeader: viewModel.sectionTitle)
                    
                case .myPlaylists(viewModel: let viewModel):

                    headerView.configure(sectionHeader: viewModel.sectionTitle)
                    
                }
               
                return headerView
            } else {
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: "headerTop", for: indexPath) as! HeaderClassTop
                headerView.protocolVar = self
                let type = sections[indexPath.section]
               
                
                switch type {
                case.recentlyPlayedFirst(viewModel: let viewModel):
                    headerView.configure(sectionHeader: viewModel.sectionTitle)
                    
                case .newRelease(viewModel: let viewModel):
                    headerView.configure(sectionHeader: viewModel.sectionTitle)
                case .featuredPlaylist(viewModel: let viewModel):
                    headerView.configure(sectionHeader: viewModel.sectionTitle)
                case .reccomendedTracks(viewModel: let viewModel):

                    headerView.configure(sectionHeader: viewModel.sectionTitle)
                case .recentlyPlayed(viewModel: let viewModel):

                    headerView.configure(sectionHeader: viewModel.sectionTitle)
                    
                case .myPlaylists(viewModel: let viewModel):

                    headerView.configure(sectionHeader: viewModel.sectionTitle)
                }
               
                return headerView
            }
          
        } else {
            return UICollectionReusableView()
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let type = sections[section]
        switch type {
        case.recentlyPlayedFirst(viewModel: let viewModel):
            return viewModel.viewModel.count
        case .newRelease(viewModel: let viewModel):
            return viewModel.viewModel.count
        case .featuredPlaylist(viewModel: let viewModel):
            return viewModel.viewModel.count
        case .reccomendedTracks(viewModel: let viewModel):
            return viewModel.viewModel.count
        case .recentlyPlayed(viewModel: let viewModel):

            return viewModel.viewModel.count
            
        case .myPlaylists(viewModel: let viewModel):

            return viewModel.viewModel.count
        }
  
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let type = sections[indexPath.section]
  
        switch type {
            
        case.recentlyPlayedFirst(viewModel: let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentlyPlayedFirstCell.identifier, for: indexPath) as? RecentlyPlayedFirstCell else {
                
                return UICollectionViewCell()
            }
            let viewModels = viewModel.viewModel[indexPath.row]
            cell.configureCell(viewModal: viewModels)
            
//            cell.backgroundColor = UIColor.init(rbg: 41, green: 41, blue: 41, alpha: 1)
            return cell
  
        case.newRelease(viewModel: let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewReleaseCollectionViewCell.identifier, for: indexPath) as? NewReleaseCollectionViewCell else {
                
                return UICollectionViewCell()
            }
            let viewModels = viewModel.viewModel[indexPath.row]
            cell.configureCell(viewModal: viewModels)
            
//            cell.backgroundColor = UIColor.init(rbg: 41, green: 41, blue: 41, alpha: 1)
            return cell
            
        case .featuredPlaylist(viewModel: let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedPlaylistCollectionViewCell.identifier, for: indexPath) as? FeaturedPlaylistCollectionViewCell else {
                
                return UICollectionViewCell()
            }
            let viewModels = viewModel.viewModel[indexPath.row]
            cell.configureCell(viewModal: viewModels)
            cell.backgroundColor = .clear
            return cell
          
        case .reccomendedTracks(viewModel: let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendedTrackCollectionViewCell.identifier, for: indexPath) as? RecommendedTrackCollectionViewCell else {
                
                return UICollectionViewCell()
            }
            let viewModels = viewModel.viewModel[indexPath.row]
            cell.configureCell(viewModal: viewModels)
            cell.backgroundColor = .clear
            return cell
        case .recentlyPlayed(viewModel: let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentlyPlayedCell.identifier, for: indexPath) as? RecentlyPlayedCell else {
                
                return UICollectionViewCell()
            }
            let viewModels = viewModel.viewModel[indexPath.row]
            cell.configureCell(viewModal: viewModels)
            cell.backgroundColor = .clear
            return cell
            
        case .myPlaylists(viewModel: let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPlaylistCell.identifier, for: indexPath) as? MyPlaylistCell else {
                
                return UICollectionViewCell()
            }
            let viewModels = viewModel.viewModel[indexPath.row]
            cell.configureCell(viewModal: viewModels)
            cell.backgroundColor = .clear
            return cell
           
        }
        
  
    }
    
}
