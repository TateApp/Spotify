import UIKit

class RecentlyPlayedFirstCell: UICollectionViewCell {
    static let identifier = "RecentlyPlayedFirstCell"
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    let _imageView = CustomImageView()
    
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted == true {
                UIView.animate(withDuration: 0.5, animations: {
                    self.transform = .init(scaleX: 0.8, y: 0.8)
                })
            } else  {
                UIView.animate(withDuration: 0.5, animations: {
                    self.transform = .identity
                })
            }
        }
    }
    let textLabel = UILabel()
    let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    func configureCell(viewModal : RecentlyPlayedFirstCellModel) {
        self.contentView.addSubview(visualEffectView)
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        visualEffectView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5).isActive = true
        visualEffectView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor ,constant: 5).isActive = true
        visualEffectView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5).isActive = true
        visualEffectView.backgroundColor = .white
        visualEffectView.alpha = 0.1
        visualEffectView.layer.cornerRadius = 5
        visualEffectView.layer.masksToBounds = true
        self.contentView.addSubview(_imageView)
        
        _imageView.translatesAutoresizingMaskIntoConstraints = false
//        _imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        _imageView.leadingAnchor.constraint(equalTo: self.visualEffectView.leadingAnchor).isActive = true
        _imageView.centerYAnchor.constraint(equalTo: self.visualEffectView.centerYAnchor).isActive = true

        self._imageView.layer.borderColor = UIColor.blue.cgColor
        _imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        _imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        _imageView.contentMode = .scaleAspectFit
      
        _imageView.loadImage(with: viewModal.artworkURL!.absoluteString)
        
        self.contentView.addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        textLabel.leadingAnchor.constraint(equalTo: _imageView.trailingAnchor, constant: 10).isActive = true
        textLabel.text = viewModal.trackName!
        textLabel.font = .boldSystemFont(ofSize: 12)
        textLabel.textColor = .white
        textLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
    }
}

