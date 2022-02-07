import UIKit

class ParticularPlaylistCell: UICollectionViewCell {
    static let identifier = "ParticularPlaylistCell"
    
    
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
    func configureCell(viewModal : ParticularPlaylistCellViewModel) {

 
        self.contentView.addSubview(_imageView)
        _imageView.translatesAutoresizingMaskIntoConstraints = false
        _imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        _imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        _imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        _imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        _imageView.loadImage(with: viewModal.artworkURL!.absoluteString )
    }
}

