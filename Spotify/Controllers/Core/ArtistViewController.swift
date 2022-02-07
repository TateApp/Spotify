import UIKit
import CoreMIDI
enum ArtistSelectionType {
    case topTracks(sectionTitle: String,viewModel: [TopTrackViewModel])
    case albums(sectionTitle: String,viewModel: [AlbumViewModel])
    case artists(sectionTitle: String,viewModel: [RelatedArtistViewModel])
}
protocol moreButtonPressed {
    func moreButtonPressed(typeOfCell: String, trackID: String, albumID: String, artistID: String, artworkURL: String, mainTitle: String, subTitle: String)
}
class ArtistViewController: UIViewController , getDataIntoPlayer_ViewController, passBackArtistID, moreButtonPressed, moreButtonDismissed {
    func moreButtonDismissed_Album(albumID: String) {
        print("moreButtonDismissed_Album")
        if _typeOfCell == "track" {
            UIView.animate(withDuration: 0.5, animations: {
                self.moreButtonView_Track.transform  = .init(translationX: 0, y: UIScreen.main.bounds.height)
            })
           
        }
        if _typeOfCell == "album" {
            UIView.animate(withDuration: 0.5, animations: {
                self.moreButtonView_Album.transform  = .init(translationX: 0, y: UIScreen.main.bounds.height)
            })
        }
        
        APICaller.shared.getAlbum(id: albumID, completion: { result in
            switch result {
            case .success(let model):
                
                DispatchQueue.main.async {
                    let vc = AlbumViewController(album: model)
                    vc.protocolVar = self
                    guard self.navigationController?.topViewController == self else { return }
                    self.navigationController?.pushViewController(vc, animated: false)
                }
                
            case .failure(let error):
                print(error)
            }
            
        })
    }
    
    func moreButtonDismissed() {
        UIView.animate(withDuration: 0.5, animations: {
            self.moreButtonView_Track.transform  = .init(translationX: 0, y: UIScreen.main.bounds.height)
        })
        UIView.animate(withDuration: 0.5, animations: {
            self.moreButtonView_Album.transform  = .init(translationX: 0, y: UIScreen.main.bounds.height)
        })
    }
    func moreButtonDismissed_Artist(artistID: String) {
        if _typeOfCell == "track" {
            UIView.animate(withDuration: 0.5, animations: {
                self.moreButtonView_Track.transform  = .init(translationX: 0, y: UIScreen.main.bounds.height)
            }, completion: { done in
                if done {
                    
                }
            })
           
        }
        if _typeOfCell == "album" {
            UIView.animate(withDuration: 0.5, animations: {
                self.moreButtonView_Album.transform  = .init(translationX: 0, y: UIScreen.main.bounds.height)
            }, completion: { done in
                if done {
                    
                }
            })
        }
        if _artistID != artistID {
            APICaller.shared.getArtist(id: artistID, completion: { result in
                switch result {
                case .success(let model):
                    
                    DispatchQueue.main.async {
                        let vc = ArtistViewController(artistID: model.id, artistImageURL: model.images[0].url)
                        vc.protocolVar = self
                        guard self.navigationController?.topViewController == self else { return }
                        self.navigationController?.pushViewController(vc, animated: false)
                    }
                    
                case .failure(let error):
                    print(error)
                }
                
            })
        }
      
    }
   
    var _typeOfCell = ""
    func moreButtonPressed(typeOfCell: String, trackID: String, albumID: String, artistID: String, artworkURL: String, mainTitle: String, subTitle: String) {
        _typeOfCell = typeOfCell
        print("MoreButtonPressed")
        if typeOfCell == "track" {
          
            APICaller.shared.getTrackInfo(id: trackID, completion: { result in
                switch result {
                case .success(let model):
                    DispatchQueue.main.async {
                        self.moreButtonView_Track = OptionView_Track(frame: .zero, trackID: trackID, albumID: model.album.id, artistID: model.artists[0].id, artworkURL: artworkURL, mainTitle: mainTitle, subTitle: subTitle)
                        self.moreButtonView_Track.protocolVar = self
                        self.view.addSubview(self.moreButtonView_Track)
                        self.moreButtonView_Track.translatesAutoresizingMaskIntoConstraints = false
                        self.moreButtonView_Track.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
                        self.moreButtonView_Track.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
                        self.moreButtonView_Track.transform = .init(translationX: 0, y: UIScreen.main.bounds.height)
                        UIView.animate(withDuration: 0.5, animations: {
                            self.moreButtonView_Track.transform = .identity
                        })
                    }
                case .failure(let error):
                    print("\(error)")
                }
                
            })
           
        }
        if typeOfCell == "album" {
            
        }
    }
    var moreButtonView_Track = OptionView_Track(frame: .zero, trackID: "", albumID: "", artistID: "", artworkURL: "", mainTitle: "", subTitle: "")
    var moreButtonView_Album = OptionView_Album(frame: .zero, albumID: "", artistID: "", artworkURL: "", mainTitle: "", subTitle: "")
    
    func passBack(id: String, artistImageURL: String) {
        DispatchQueue.main.async {
            let vc =  ArtistViewController(artistID: id, artistImageURL: artistImageURL)
            vc.protocolVar = self
            guard self.navigationController?.topViewController == self else { return }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func passBackData(trackID: String) {
        protocolVar?.passBackData(trackID: trackID)
    }
    var protocolVar : getDataIntoPlayer_ViewController?
    var _artistID = String()
    var _artistImageURL = String()
    var _artist : GetArtistResponse?
    init(artistID: String, artistImageURL: String) {
        super.init(nibName: nil, bundle: nil)
        _artistImageURL = artistImageURL
        _artistID = artistID
        
    }
    var sections = [ArtistSelectionType]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .init(rbg: 18, green: 18, blue: 18, alpha: 1)
        setupUI()
        setupHiddenNavBar()
        getArtistInfo()
        fetchData()
    }
  
    let largeImageView = CustomImageView()
    let largeTitle = UILabel()
    var hiddenNavBar = Gradient(frame: .zero, gradientColor: [UIColor.blue.cgColor, UIColor.blue.cgColor], location: [0.0,1.0], type: .axial, startPoint: nil, endPoint: nil)
    var hiddenNavBarTitle = UILabel()
    var hiddenNavBarAlpha = 0.0
    let backButton = UIButton(type: .system)
    func setupUI() {
        self.view.addSubview(largeImageView)
        largeImageView.translatesAutoresizingMaskIntoConstraints = false
        largeImageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        largeImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        largeImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        largeImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        largeImageView.loadImage(with: _artistImageURL)
        
        self.view.addSubview(largeTitle)
        largeTitle.translatesAutoresizingMaskIntoConstraints = false
        largeTitle.bottomAnchor.constraint(equalTo: largeImageView.bottomAnchor, constant: -100).isActive = true
        largeTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        largeTitle.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        largeTitle.font = .boldSystemFont(ofSize: 40)
        largeTitle.textColor = .white
    }
    func getArtistInfo() {
        APICaller.shared.getArtist(id: _artistID, completion: { result in
            switch result {
            case .success(let artist ):
                self._artist = artist
                DispatchQueue.main.async {
                    self.largeTitle.text = self._artist!.name
                    self.hiddenNavBarTitle.text = self._artist!.name
                }
            case.failure(let error):
                print(error)
            }
        })
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
    func fetchData() {
        loading.startAnimating()
        let group = DispatchGroup()
        
        group.enter()
        group.enter()
        group.enter()
        var getArtistTopTracks: ArtistTopTracksReponse?
        var getArtistAlbums: ArtistAlbumResponse?
        var getArtistRelatedArtists: ArtistRelatedArtistResponse?
        APICaller.shared.getArtistTopTracks(id: _artistID, completion: { result in
            defer {
                group.leave()
            }
            switch result {
            case .success(let response):
                getArtistTopTracks = response
            case .failure(let error):
                print(error)
            }
        })
        APICaller.shared.getArtistAlbums(id: _artistID, completion: { result in
            defer {
                group.leave()
            }
            switch result {
            case .success(let response):
                getArtistAlbums = response
            case .failure(let error):
                print(error)
            }
        })
        APICaller.shared.getArtistRelatedArtists(id: _artistID, completion: { result in
            defer {
                group.leave()
            }
            switch result {
            case .success(let response):
                getArtistRelatedArtists = response
            case .failure(let error):
                print(error)
            }
        })
        group.notify(queue: .main) { [self] in
            //Configure Model
            guard let getArtistTopTracks_ = getArtistTopTracks?.tracks,
                  let getArtistAlbums_ = getArtistAlbums?.items,
                  let getArtistRelatedArtists_ = getArtistRelatedArtists?.artists else {
                  
                  print("API Failure")
                  self.gotHere()
                  return
              
              }
            loading.stopAnimating()
            configureModel(getArtistTopTracks: getArtistTopTracks_ , getArtistAlbums: getArtistAlbums_, getArtistRelatedArtists: getArtistRelatedArtists_)
            
        
    }
    }
        func gotHere() {
            fetchData()
        }
        func configureModel(getArtistTopTracks: [ArtistTopTracks], getArtistAlbums: [ArtistAlbumItems], getArtistRelatedArtists:  [ArtistRelatedArtist]) {
            print(getArtistTopTracks.count)
            print(getArtistAlbums.count)
          
            print(getArtistRelatedArtists.count)
            
            var listOfAlbums = [String]()
            var _getArtistAlbums = [ArtistAlbumItems]()
            for index in 0...getArtistAlbums.count - 1 {
                if !listOfAlbums.contains(getArtistAlbums[index].name) {
                    listOfAlbums.append(getArtistAlbums[index].name)
                    _getArtistAlbums.append(getArtistAlbums[index])
                }
            }
            
sections.append(.topTracks(sectionTitle: "Popular", viewModel: [TopTrackViewModel(albumName: "", artworkURL: nil, artistName: "", trackName: "", id:"")]))
            sections.append(.topTracks(sectionTitle: "Popular", viewModel: getArtistTopTracks.compactMap({
                return TopTrackViewModel(albumName: $0.album.name, artworkURL: URL(string: $0.album.images.first?.url ?? ""), artistName: $0.artists[0].name, trackName: $0.name, id: $0.id)
            })))
            sections.append(.albums(sectionTitle: "Popular Releases", viewModel: _getArtistAlbums.compactMap({
                return AlbumViewModel(albumName: $0.name, artworkURL: URL(string: $0.images.first?.url ?? ""), artistName: $0.artists[0].name, releaseDate: $0.release_date, id: $0.id)
            })))
            sections.append(.artists(sectionTitle: "Fans also liked", viewModel: getArtistRelatedArtists.compactMap({
                return RelatedArtistViewModel(artworkURL:  URL(string: $0.images.first?.url ?? ""), artistName: $0.name, id: $0.id)
            })))
            
            setupTableView()
//            print(section)
    }
    var hiddenNavBarSafeAreaGuide = Gradient(frame: .zero, gradientColor: [UIColor.blue.cgColor, UIColor.blue.cgColor], location: [0.0,1.0], type: .axial, startPoint: nil, endPoint: nil)
    func setupHiddenNavBar() {
        
        
     
        self.view.addSubview(hiddenNavBarSafeAreaGuide)
        hiddenNavBarSafeAreaGuide.translatesAutoresizingMaskIntoConstraints = false
        hiddenNavBarSafeAreaGuide.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        hiddenNavBarSafeAreaGuide.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        hiddenNavBarSafeAreaGuide.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        hiddenNavBarSafeAreaGuide.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        hiddenNavBarSafeAreaGuide.alpha = 0
        
        self.view.addSubview(hiddenNavBar)
        hiddenNavBar.translatesAutoresizingMaskIntoConstraints = false
        hiddenNavBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        hiddenNavBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        hiddenNavBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        hiddenNavBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        hiddenNavBar.alpha = 0
        
        self.hiddenNavBar.addSubview(hiddenNavBarTitle)
        hiddenNavBarTitle.translatesAutoresizingMaskIntoConstraints = false
        hiddenNavBarTitle.bottomAnchor.constraint(equalTo: hiddenNavBar.bottomAnchor, constant: -20).isActive = true
        hiddenNavBarTitle.centerXAnchor.constraint(equalTo: hiddenNavBar.centerXAnchor).isActive = true
    
        hiddenNavBarTitle.textColor = .white
        hiddenNavBarTitle.font = .boldSystemFont(ofSize: 15)
        
        self.view.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.centerYAnchor.constraint(equalTo: self.hiddenNavBarTitle.centerYAnchor).isActive = true
        backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        backButton.setTitle("<", for: .normal)
        backButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        backButton.setTitleColor(.white, for: .normal)
        backButton.addTarget(self, action: #selector(backButtonPressed(sender:)), for: .touchUpInside)
    }
    @objc func backButtonPressed(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    var tableView =  UITableView(frame: .zero, style: .plain)
    func setupTableView() {
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: -50).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Hidden")
        tableView.register(ArtistPopularTracksUITableViewCell.self, forCellReuseIdentifier: ArtistPopularTracksUITableViewCell.identifier)
        tableView.register(ArtistAlbumUITableViewCell.self, forCellReuseIdentifier: ArtistAlbumUITableViewCell.identifier)
        tableView.register(ArtistRelatedArtistUITableViewCell.self, forCellReuseIdentifier: ArtistRelatedArtistUITableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        
        self.view.bringSubviewToFront(hiddenNavBarSafeAreaGuide)
        self.view.bringSubviewToFront(hiddenNavBar)
        self.view.bringSubviewToFront(hiddenNavBarTitle)
        self.view.bringSubviewToFront(backButton)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var done =  false
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        done = true
      
    }
   
}
extension ArtistViewController : UITableViewDelegate, UITableViewDataSource {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 200 {
            self.largeImageView.alpha = 0
            UIView.animate(withDuration: 0.5, animations: {
                self.hiddenNavBarSafeAreaGuide.alpha = 1
                self.hiddenNavBar.alpha = 1
                self.hiddenNavBarTitle.alpha = 1
            })
            
        } else {
            self.largeImageView.alpha = 1
            UIView.animate(withDuration: 0.5, animations: {
                self.hiddenNavBarSafeAreaGuide.alpha = 0
                self.hiddenNavBar.alpha = 0
                self.hiddenNavBarTitle.alpha = 0
            })
        }
        print(scrollView.contentOffset.y)
       
            largeTitle.transform = .init(translationX: 0, y: 0 - scrollView.contentOffset.y + -20)
        
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        if indexPath.section != 0 {
            
    
        let type = sections[indexPath.section]
    
        switch type {
        case .topTracks(viewModel: let viewModel):
            let cell = tableView.dequeueReusableCell(withIdentifier: ArtistPopularTracksUITableViewCell.identifier, for: indexPath) as! ArtistPopularTracksUITableViewCell
            cell.configure(viewModel: viewModel.viewModel[indexPath.row], index: indexPath.row)
            cell.backgroundColor = self.view.backgroundColor
            cell.moreButtonPressedDelegate = self
            cell.selectionStyle = .none
return cell
        case .albums( viewModel: let viewModel):
            let cell = tableView.dequeueReusableCell(withIdentifier: ArtistAlbumUITableViewCell.identifier, for: indexPath) as! ArtistAlbumUITableViewCell
            cell.configure(viewModel: viewModel.viewModel[indexPath.row])
            cell.backgroundColor = self.view.backgroundColor
            cell.selectionStyle = .none
            cell.moreButtonPressedDelegate = self
            return cell
            
        case .artists(viewModel: let viewModel):
            
            let cell = tableView.dequeueReusableCell(withIdentifier: ArtistRelatedArtistUITableViewCell.identifier, for: indexPath) as! ArtistRelatedArtistUITableViewCell
            cell.protocolVar = self
            cell.configure(viewModel: viewModel.viewModel)
            cell.backgroundColor = self.view.backgroundColor
            cell.selectionStyle = .none
            cell.moreButtonPressedDelegate = self
            return cell
        }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Hidden", for: indexPath)
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            return cell
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section != 0 {
        let type = sections[section]
        let label = UILabel()
   
        switch type {
        case .topTracks(viewModel: let viewModel):
            label.text = viewModel.sectionTitle
        case .albums( viewModel: let viewModel):
//            cell.textLabel!.text = viewModel.viewModel[indexPath.row].albumName
            label.text = viewModel.sectionTitle
        case .artists(viewModel: let viewModel):
//            cell.textLabel!.text = viewModel.viewModel[indexPath.row].artistName
            label.text = viewModel.sectionTitle
        }
            
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .white
        return label
        } else {
            return UIView()
        }
    }
   
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section != 0 {
        let type = sections[indexPath.section]
        
        
            switch type {
            case .topTracks(viewModel: let viewModel):
                    return 70
            case .albums( viewModel: let viewModel):
                return 100
                
            case .artists(viewModel: let viewModel):
                return 150
            }
        } else {
            return 40
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section != 0 {
            
        
        let type = sections[section]
        
        
            switch type {
            case .topTracks(viewModel: let viewModel):
                return viewModel.viewModel.count
            case .albums( viewModel: let viewModel):
                return viewModel.viewModel.count
                
            case .artists(viewModel: let viewModel):
                
                return 1
            }
        } else {
            return 7
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = sections[indexPath.section]
        
        
            switch type {
            case .topTracks(viewModel: let viewModel):
                protocolVar?.passBackData(trackID: viewModel.viewModel[indexPath.row].id)
            case .albums( viewModel: let viewModel):
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
            case .artists(viewModel: let viewModel):
               print("Wow")
                
               
    }
    }
    
}
protocol passBackArtistID {
    func passBack(id: String, artistImageURL: String)
}
class RelatedArtistUICollectionView : UICollectionView , UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    var protocolVar : passBackArtistID?
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        protocolVar?.passBack(id: _RelatedArtistViewModel_![indexPath.row].id, artistImageURL: _RelatedArtistViewModel_![indexPath.row].artworkURL!.absoluteString)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        _RelatedArtistViewModel_!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.dequeueReusableCell(withReuseIdentifier: "RelatedArtist", for: indexPath) as! RelatedArtistUICollectionViewUICollectionViewCell
        cell.configureCell(_RelatedArtistViewModel: _RelatedArtistViewModel_![indexPath.row])
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
    var  _RelatedArtistViewModel_ : [RelatedArtistViewModel]?
     init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout, _RelatedArtistViewModel: [RelatedArtistViewModel]) {
        super.init(frame: frame, collectionViewLayout: layout)
         _RelatedArtistViewModel_ = _RelatedArtistViewModel
         
         self.delegate = self
         self.dataSource = self
         self.register(RelatedArtistUICollectionViewUICollectionViewCell.self, forCellWithReuseIdentifier: "RelatedArtist")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class RelatedArtistUICollectionViewUICollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    let apiImageView = CustomImageView()
    let mainLabel = UILabel()
    
    func configureCell(_RelatedArtistViewModel: RelatedArtistViewModel) {
     
        self.contentView.addSubview(apiImageView)
        apiImageView.loadImage(with: _RelatedArtistViewModel.artworkURL!.absoluteString)
        apiImageView.translatesAutoresizingMaskIntoConstraints = false
        apiImageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        apiImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        apiImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: -10).isActive = true
        apiImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        
        apiImageView.layer.cornerRadius = 60
        apiImageView.layer.masksToBounds = true
        
        self.contentView.addSubview(mainLabel)
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        mainLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5).isActive = true
        mainLabel.text = _RelatedArtistViewModel.artistName
        mainLabel.font = .boldSystemFont(ofSize: 12)
        mainLabel.textColor = .white
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
