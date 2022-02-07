import UIKit

class PlayerViewController: UIViewController {
    let queue = [String]()
    var protocolVar: moreButtonPressed?
    var albumArt = CustomImageView()
    let moreButton = UIButton(type: .system)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .init(rbg: 18, green: 18, blue: 18, alpha: 1)
        
        setupAlbumArt()
        setupLabels()
//        setupSlider()
    }
    
    func setupAlbumArt() {
        self.view.addSubview(albumArt)
        albumArt.translatesAutoresizingMaskIntoConstraints = false
        albumArt.translatesAutoresizingMaskIntoConstraints = false
        albumArt.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        albumArt.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        albumArt.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        albumArt.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height - 100).isActive = true
        albumArt.contentMode = .scaleAspectFill
    }
    let topAlbumLabel = UILabel()
    let songNameLabel = UILabel()
    let artistLabel = UILabel()
    
    let visualEffectView = Gradient(frame: .zero, gradientColor: [UIColor.clear.cgColor , UIColor.clear.cgColor, UIColor.black.cgColor] ,location: [0.0,0.1,1.0], type: .axial, startPoint: nil, endPoint: nil)
    let slider = UISlider()
    

    
    func setupLabels () {
        self.view.addSubview(topAlbumLabel)
        topAlbumLabel.translatesAutoresizingMaskIntoConstraints = false
        topAlbumLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50).isActive = true
        topAlbumLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        topAlbumLabel.text = "Album Label"
        topAlbumLabel.textColor = .white
        topAlbumLabel.font = .boldSystemFont(ofSize: 12)
        
        self.view.addSubview(visualEffectView)
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        visualEffectView.topAnchor.constraint(equalTo: albumArt.bottomAnchor, constant: -60).isActive = true
        visualEffectView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        visualEffectView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true

  
        self.view.addSubview(songNameLabel)
        songNameLabel.translatesAutoresizingMaskIntoConstraints = false
        songNameLabel.bottomAnchor.constraint(equalTo: self.albumArt.bottomAnchor, constant: -100).isActive = true
        songNameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        songNameLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        songNameLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        songNameLabel.font = .boldSystemFont(ofSize: 25)
        songNameLabel.textColor = .white
        songNameLabel.textAlignment = .left
        
        
        self.view.addSubview(artistLabel)
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        artistLabel.topAnchor.constraint(equalTo: self.songNameLabel.bottomAnchor, constant: 5).isActive = true
        artistLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        artistLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        artistLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        artistLabel.font = .boldSystemFont(ofSize: 15)
        artistLabel.textColor = .systemGray3
        artistLabel.textAlignment = .left
        artistLabel.text = ""
        
        
        
        self.view.sendSubviewToBack(albumArt)
        
        
    }
   
    func setupSlider(){
        self.view.addSubview(slider)
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: 20).isActive = true
        slider.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        slider.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        slider.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
    }
    func setupPlayButtons() {
        
    }
    var _track: AudioTrack?
    
    func loadData(track: AudioTrack) {
        _track = track
        albumArt.loadImage(with: track.album.images[0].url)
        topAlbumLabel.text = track.album.name
        songNameLabel.text = track.name
        for index in 0...track.artists.count - 1 {
            
            artistLabel.text =  artistLabel.text! + track.artists[index].name + " "
        }
       
    }
}
