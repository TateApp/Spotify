import UIKit

class ArtistPopularTracksUITableViewCell : UITableViewCell {
    var moreButtonPressedDelegate: moreButtonPressed?
    static let identifier  = "ArtistPopularTracksUITableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    let indexLabel = UILabel()
    
    let apiImageView = CustomImageView()
    let mainLabel = UILabel()
    
    let subLabel = UILabel()
    let moreButton = UIButton()
    @objc func moreButtonPressed(sender: UIButton) {
        moreButtonPressedDelegate?.moreButtonPressed(typeOfCell: "track", trackID: topTrackViewModel!.id, albumID: "", artistID: "", artworkURL: topTrackViewModel?.artworkURL!.absoluteString ?? "", mainTitle: topTrackViewModel!.trackName!, subTitle: topTrackViewModel!.albumName!)
    }
    var topTrackViewModel : TopTrackViewModel?
    func configure(viewModel: TopTrackViewModel, index: Int) {
        topTrackViewModel = viewModel
        
        self.contentView.addSubview(moreButton)
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        moreButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        moreButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        moreButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        moreButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        moreButton.setTitle("...", for: .normal)
        moreButton.setTitleColor(.systemGray3, for: .normal)
        moreButton.addTarget(self, action: #selector(moreButtonPressed(sender:)), for: .touchUpInside)
        self.contentView.addSubview(indexLabel)
        indexLabel.translatesAutoresizingMaskIntoConstraints = false
        indexLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        indexLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        indexLabel.text = "\(index + 1)"
        indexLabel.font = .systemFont(ofSize: 15)
        indexLabel.textColor = .white
        indexLabel.widthAnchor.constraint(equalToConstant: 20).isActive = true
        indexLabel.textAlignment = .center
        
        self.contentView.addSubview(apiImageView)
        apiImageView.translatesAutoresizingMaskIntoConstraints = false
        apiImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        apiImageView.leadingAnchor.constraint(equalTo: self.indexLabel.trailingAnchor, constant: 10).isActive = true
        apiImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        apiImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        apiImageView.loadImage(with: viewModel.artworkURL!.absoluteString)
        
        self.contentView.addSubview(mainLabel)
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: -10).isActive = true
        mainLabel.leadingAnchor.constraint(equalTo: apiImageView.trailingAnchor, constant: 10).isActive = true
        mainLabel.trailingAnchor.constraint(equalTo: self.moreButton.leadingAnchor, constant: -10).isActive = true
        mainLabel.text = viewModel.trackName
        mainLabel.font = .systemFont(ofSize: 15)
        mainLabel.textColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class ArtistAlbumUITableViewCell : UITableViewCell {
    var moreButtonPressedDelegate: moreButtonPressed?
    static let identifier  = "ArtistAlbumUITableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    let apiImageView = CustomImageView()
    
    let mainLabel = UILabel()
    let subLabel = UILabel()
    func configure(viewModel: AlbumViewModel) {
      
        self.contentView.addSubview(apiImageView)
        apiImageView.translatesAutoresizingMaskIntoConstraints = false
        apiImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        apiImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        apiImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        apiImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        apiImageView.loadImage(with: viewModel.artworkURL!.absoluteString)
        
        self.contentView.addSubview(mainLabel)
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: -10).isActive = true
        mainLabel.leadingAnchor.constraint(equalTo: apiImageView.trailingAnchor, constant: 10).isActive = true
        mainLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        mainLabel.text = viewModel.albumName
        mainLabel.font = .boldSystemFont(ofSize: 18)
        mainLabel.textColor = .white
        
        
        self.contentView.addSubview(subLabel)
        subLabel.translatesAutoresizingMaskIntoConstraints = false
        subLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: 10).isActive = true
        subLabel.leadingAnchor.constraint(equalTo: apiImageView.trailingAnchor, constant: 10).isActive = true
        subLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        subLabel.text = "Album - \(viewModel.releaseDate)"
        subLabel.font = .systemFont(ofSize: 12)
        subLabel.textColor = .systemGray3
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class ArtistRelatedArtistUITableViewCell : UITableViewCell , passBackArtistID {
    var moreButtonPressedDelegate: moreButtonPressed?
    
    var protocolVar: passBackArtistID?
    func passBack(id: String, artistImageURL: String) {
        protocolVar?.passBack(id: id, artistImageURL: artistImageURL)
    }
    
    static let identifier  = "ArtistRelatedArtistUITableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    var collectionView = RelatedArtistUICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout(), _RelatedArtistViewModel: [RelatedArtistViewModel]())
    func configure(viewModel: [RelatedArtistViewModel]) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = RelatedArtistUICollectionView(frame: .zero, collectionViewLayout: layout, _RelatedArtistViewModel: viewModel)
        self.contentView.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        collectionView.backgroundColor = .clear
        collectionView.protocolVar = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
