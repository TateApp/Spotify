import UIKit

class NewReleaseCollectionViewCell: UICollectionViewCell {
    static let identifier = "NewReleaseCollectionViewCell"
    
    
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
                UIView.animate(withDuration: 0.25, animations: {
                    self.transform = .init(scaleX: 0.8, y: 0.8)
                })
            } else  {
                UIView.animate(withDuration: 0.25, animations: {
                    self.transform = .identity
                })
            }
        }
    }
    let textLabel = UILabel()
    let subLabel = UILabel()
    func configureCell(viewModal : NewReleaseCellViewModel) {
      
        self.contentView.addSubview(_imageView)
        _imageView.translatesAutoresizingMaskIntoConstraints = false
        _imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        _imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        _imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        _imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        _imageView.loadImage(with: viewModal.artworkURL?.absoluteString  ?? "")
        
        self.contentView.addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.topAnchor.constraint(equalTo: _imageView.bottomAnchor, constant: 5).isActive = true
        textLabel.leadingAnchor.constraint(equalTo: _imageView.leadingAnchor).isActive = true
        textLabel.trailingAnchor.constraint(equalTo: _imageView.trailingAnchor).isActive = true
        
        textLabel.font = .boldSystemFont(ofSize: 12)
        textLabel.text = viewModal.albumName!
        textLabel.textColor = .white
        
        
        self.contentView.addSubview(subLabel)
        subLabel.translatesAutoresizingMaskIntoConstraints = false
        subLabel.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 5).isActive = true
        subLabel.leadingAnchor.constraint(equalTo: _imageView.leadingAnchor).isActive = true
        subLabel.trailingAnchor.constraint(equalTo: _imageView.trailingAnchor).isActive = true
        
        subLabel.font = .boldSystemFont(ofSize: 12)
        subLabel.text = viewModal.artistName
        subLabel.textColor = .systemGray
    }
}
