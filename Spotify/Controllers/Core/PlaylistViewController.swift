import UIKit
struct PlaylistDataModelSection {
    var sectionRow : PlayListDataModelRow
}
struct PlayListDataModelRow {
    var row : PlaylistPressedResponse
}
protocol optionClosePressed {
    func closePressed()

}
class PlaylistViewController: UIViewController, moreButtonPressed, moreButtonDismissed, getDataIntoPlayer_ViewController  {
    func passBackData(trackID: String) {
        protocolVar?.passBackData(trackID: trackID)
    }
    
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
   
    var _typeOfCell = ""
    func moreButtonPressed(typeOfCell: String, trackID: String, albumID: String, artistID: String, artworkURL: String, mainTitle: String, subTitle: String) {
        _typeOfCell = typeOfCell
        print("MoreButtonPressed")
        if typeOfCell == "track" {
          
            
            APICaller.shared.getTrackInfo(id: trackID, completion: { result in
                switch result {
                case .success(let model):
                    DispatchQueue.main.async {
                        self.moreButtonView_Track = OptionView_Track(frame: .zero, trackID: trackID, albumID: model.album.id, artistID: model.artists[0].id, artworkURL: model.album.images[0].url, mainTitle: mainTitle, subTitle: subTitle)
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
    
    var protocolVar : getDataIntoPlayer_ViewController?
  
    var tableView = UITableView(frame: .zero, style: .plain)
    var dataModel = [PlaylistDataModelSection]()
override func viewDidLoad() {
super.viewDidLoad()

    self.view.backgroundColor = .init(rbg: 18, green: 18, blue: 18, alpha: 1)
    setupDataModel()
    setupCoreView()
    setupLargeImage()
    setupGradient()
    setupTitles()
    setupHiddenNavBar()
    
    setupTableView()

}
   
    func setupDataModel() {
        dataModel = [
            PlaylistDataModelSection(sectionRow:    PlayListDataModelRow(row: _playlist!)),
            PlaylistDataModelSection(sectionRow:    PlayListDataModelRow(row: _playlist!))
            
        ]
    }
    func setupCoreView() {
        self.view.addSubview(coreView)
        coreView.translatesAutoresizingMaskIntoConstraints = false
        coreView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50).isActive = true
        coreView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        coreView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        coreView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
    }
    let coreView = UIView()
    
    let largeImage = CustomImageView()
    var gradient = Gradient(frame: .zero, gradientColor: [UIColor.blue.cgColor, UIColor.blue.cgColor], location: [0.0,1.0], type: .axial, startPoint: nil, endPoint: nil)
   
    let largeTitle = UILabel()
    let ownerSubTitle = UILabel()
    let ownerImage = CustomImageView()
    
    
    var hiddenNavBar = Gradient(frame: .zero, gradientColor: [UIColor.blue.cgColor, UIColor.blue.cgColor], location: [0.0,1.0], type: .axial, startPoint: nil, endPoint: nil)
    var hiddenNavBarTitle = UILabel()
    
    let bigShuffleButton = UIButton()
    let backButton = UIButton()
    
    func setupTableView() {
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.hiddenNavBar.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "test")
        tableView.register(PlaylistTableCell.self, forCellReuseIdentifier: "PlaylistView")
        tableView.separatorStyle = .none
        
    }
    func setupLargeImage() {
        self.view.addSubview(largeImage)
        largeImage.translatesAutoresizingMaskIntoConstraints = false
        largeImage.topAnchor.constraint(equalTo: self.coreView.topAnchor, constant: 20).isActive = true
        largeImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        largeImage.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 1.5).isActive = true
        largeImage.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 1.5).isActive = true
    
        if _playlist!.images.first?.url != nil {
            largeImage.loadImage(with: _playlist!.images.first!.url)
        }
      
    
        gradient = Gradient(frame: .zero, gradientColor: [largeImage.image?.averageColor?.cgColor ?? UIColor.blue.cgColor, UIColor.init(rbg: 18, green: 18, blue: 18, alpha: 1).cgColor], location: [0.0,1.0], type: .axial, startPoint: nil, endPoint: nil)
        
        hiddenNavBar = Gradient(frame: .zero, gradientColor: [largeImage.image?.averageColor?.cgColor ?? UIColor.blue.cgColor, UIColor.init(rbg: 18, green: 18, blue: 18, alpha: 1).cgColor], location: [1.0,1.0], type: .axial, startPoint: nil, endPoint: nil)
        
        hiddenNavBarSafeAreaGuide = Gradient(frame: .zero, gradientColor: [largeImage.image?.averageColor?.cgColor ?? UIColor.blue.cgColor, UIColor.init(rbg: 18, green: 18, blue: 18, alpha: 1).cgColor], location: [1.0,1.0], type: .axial, startPoint: nil, endPoint: nil)
        
        
    }
    func setupGradient() {
        self.view.addSubview(gradient)
        gradient.translatesAutoresizingMaskIntoConstraints = false
        gradient.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        gradient.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        gradient.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        gradient.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height -  (UIScreen.main.bounds.height / 4)).isActive = true
        
        self.view.bringSubviewToFront(largeImage)
    }
    func setupTitles() {
        self.view.addSubview(largeTitle)
        largeTitle.translatesAutoresizingMaskIntoConstraints = false
        largeTitle.topAnchor.constraint(equalTo: self.largeImage.bottomAnchor, constant: 10).isActive = true
        largeTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        largeTitle.text = _playlist?.name
        largeTitle.font = .boldSystemFont(ofSize: 25)
        largeTitle.textColor = .white
       
    }
    var hiddenNavBarAlpha = 0.0
    var largeImageScale = 1.0
    var hiddenNavBarSafeAreaGuide = Gradient(frame: .zero, gradientColor: [UIColor.blue.cgColor, UIColor.blue.cgColor], location: [0.0,1.0], type: .axial, startPoint: nil, endPoint: nil)
    func setupHiddenNavBar() {
        
        
     
        self.view.addSubview(hiddenNavBarSafeAreaGuide)
        hiddenNavBarSafeAreaGuide.translatesAutoresizingMaskIntoConstraints = false
        hiddenNavBarSafeAreaGuide.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        hiddenNavBarSafeAreaGuide.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        hiddenNavBarSafeAreaGuide.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        hiddenNavBarSafeAreaGuide.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        hiddenNavBarSafeAreaGuide.alpha = hiddenNavBarAlpha
        
        self.view.addSubview(hiddenNavBar)
        hiddenNavBar.translatesAutoresizingMaskIntoConstraints = false
        hiddenNavBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        hiddenNavBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        hiddenNavBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        hiddenNavBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        hiddenNavBar.alpha = hiddenNavBarAlpha
        
      
        
        self.hiddenNavBar.addSubview(hiddenNavBarTitle)
        hiddenNavBarTitle.translatesAutoresizingMaskIntoConstraints = false
        hiddenNavBarTitle.bottomAnchor.constraint(equalTo: hiddenNavBar.bottomAnchor, constant: -20).isActive = true
        hiddenNavBarTitle.centerXAnchor.constraint(equalTo: hiddenNavBar.centerXAnchor).isActive = true
        hiddenNavBarTitle.text = _playlist?.name
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
    var _playlist : PlaylistPressedResponse?
    
init(playlist: PlaylistPressedResponse) {
super.init(nibName: nil, bundle: nil)
    _playlist = playlist
    
    
}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension PlaylistViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        dataModel.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "test", for: indexPath)
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlaylistView", for: indexPath) as! PlaylistTableCell
            cell.setup(playlistItem: (_playlist?.tracks.items[indexPath.row])!)
            cell.selectionStyle = .default
            cell.protocolVar = self
            return cell
        }
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        protocolVar?.passBackData(trackID: dataModel[indexPath.section].sectionRow.row.tracks.items[indexPath.row].track.id)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset)
      
     
            
     
        if scrollView.contentOffset.y < 130 {
            hiddenNavBarSafeAreaGuide.alpha = 0.0
            hiddenNavBar.alpha = 0.0
            self.largeTitle.alpha = 1.0
            self.ownerSubTitle.alpha = 1.0
            self.largeImage.alpha = 1.0
            self.largeImageScale = 1.0
        }
        if scrollView.contentOffset.y > 140 {
            hiddenNavBarSafeAreaGuide.alpha = 0.1
            hiddenNavBar.alpha = 0.1
            self.largeTitle.alpha = 0.8
            self.ownerSubTitle.alpha = 0.8
            self.largeImage.alpha = 0.8
            self.largeImageScale = 0.8
        }
        if scrollView.contentOffset.y > 150 {
            hiddenNavBarSafeAreaGuide.alpha = 0.2
            hiddenNavBar.alpha = 0.2
            self.largeTitle.alpha = 0.6
            self.ownerSubTitle.alpha = 0.6
            self.largeImage.alpha = 0.6
            self.largeImageScale = 0.6
        }
        if scrollView.contentOffset.y > 160 {
            hiddenNavBarSafeAreaGuide.alpha = 0.3
            hiddenNavBar.alpha = 0.3
            self.largeTitle.alpha = 0.5
            self.ownerSubTitle.alpha = 0.5
            self.largeImage.alpha = 0.5
            self.largeImageScale = 0.5
        }
        if scrollView.contentOffset.y > 170 {
            hiddenNavBarSafeAreaGuide.alpha = 0.4
            hiddenNavBar.alpha = 0.4
            self.largeTitle.alpha = 0.4
            self.ownerSubTitle.alpha = 0.4
            self.largeImage.alpha = 0.4
            self.largeImageScale = 0.4
        }
        if scrollView.contentOffset.y > 180 {
            hiddenNavBarSafeAreaGuide.alpha = 0.5
            hiddenNavBar.alpha = 0.5
            self.largeTitle.alpha = 0.3
            self.ownerSubTitle.alpha = 0.3
            self.largeImage.alpha = 0.3
            self.largeImageScale = 0.1
        }
        if scrollView.contentOffset.y > 200 {
            hiddenNavBarSafeAreaGuide.alpha = 0.6
            hiddenNavBar.alpha = 0.6
            self.largeTitle.alpha = 0.0
            self.ownerSubTitle.alpha = 0.0
            self.largeImage.alpha = 0.0
            
        }
        if scrollView.contentOffset.y > 220 {
            hiddenNavBarSafeAreaGuide.alpha = 0.7
            hiddenNavBar.alpha = 0.7
            self.largeTitle.alpha = 0.0
            self.ownerSubTitle.alpha = 0.0
            self.largeImage.alpha = 0.0
        }
        if scrollView.contentOffset.y > 240 {
            hiddenNavBarSafeAreaGuide.alpha = 1.0
            hiddenNavBar.alpha = 1.0
            self.largeTitle.alpha = 0.0
            self.ownerSubTitle.alpha = 0.0
            self.largeImage.alpha = 0.0
            
        }
       
        
            if scrollView.contentOffset.y < 170 {
                self.largeTitle.transform = .init(translationX: 0, y: 0 - scrollView.contentOffset.y)
                self.ownerSubTitle.transform = .init(translationX: 0, y: 0 - scrollView.contentOffset.y)
                self.largeImage.transform = .init(translationX: 0, y: 0 - scrollView.contentOffset.y)
//                self.tableView.transform = .init(translationX: 0, y: 0 - scrollView.contentOffset.y)
            }
           
     
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 6
        } else if section == 1 {
           return dataModel[section].sectionRow.row.tracks.items.count
        } else {
            return 0
        }
      
        
    }
    
}
protocol optionPressed_Playlist  {
    func optionPressed(sender: PlaylistItems)
}
class PlaylistTableCell : UITableViewCell {
    var protocolVar : moreButtonPressed?
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
    }
    let mainLabel = UILabel()
    let subLabel = UILabel()
    let optionsButton = UIButton()
    
    let customImage = CustomImageView()
    
    var _playlistItem: PlaylistItems?
    func setup(playlistItem: PlaylistItems) {
        _playlistItem = playlistItem
        self.contentView.addSubview(customImage)
        customImage.translatesAutoresizingMaskIntoConstraints = false
  
        customImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        customImage.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        customImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        customImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        customImage.backgroundColor = .init(rbg: 41, green: 41, blue: 41, alpha: 1)
        customImage.loadImage(with: playlistItem.track.album.images.first?.url ?? "")
        
        
        self.contentView.addSubview(optionsButton)
        optionsButton.translatesAutoresizingMaskIntoConstraints = false
        optionsButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        optionsButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        optionsButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        optionsButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        optionsButton.setTitle("...", for: .normal)
        optionsButton.addTarget(self, action: #selector(optionsButtonPressed(sender:)), for: .touchUpInside)
        self.contentView.addSubview(mainLabel)
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.topAnchor.constraint(equalTo: self.customImage.topAnchor).isActive = true
        mainLabel.leadingAnchor.constraint(equalTo: self.customImage.trailingAnchor, constant: 10).isActive = true
        mainLabel.trailingAnchor.constraint(equalTo: self.optionsButton.leadingAnchor, constant: -10).isActive = true
        mainLabel.text = playlistItem.track.name
        mainLabel.textColor = .white
        mainLabel.font = .systemFont(ofSize: 15)
        
  
        
        self.contentView.addSubview(subLabel)
        subLabel.translatesAutoresizingMaskIntoConstraints = false
        subLabel.topAnchor.constraint(equalTo: self.mainLabel.bottomAnchor).isActive = true
        subLabel.leadingAnchor.constraint(equalTo: self.customImage.trailingAnchor, constant: 10).isActive = true
        subLabel.text = playlistItem.track.artists.first?.name
        subLabel.textColor = .systemGray3
        subLabel.font = .systemFont(ofSize: 12)
        
       
        
    }
    @objc func optionsButtonPressed(sender: UIButton) {
        protocolVar?.moreButtonPressed(typeOfCell: "track", trackID: _playlistItem!.track.id, albumID: _playlistItem!.track.album.id, artistID: _playlistItem!.track.artists[0].id, artworkURL: _playlistItem!.track.album.images[0].url, mainTitle: _playlistItem!.track.name, subTitle: _playlistItem!.track.artists[0].name)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
