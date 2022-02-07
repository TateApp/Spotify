import UIKit

class GenreCollectionViewCell: UICollectionViewCell {
    static let identifier = "GenreCollectionViewCell"
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .blue
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let genreImage = CustomImageView()
    let textLabel = UILabel()
    override var isHighlighted: Bool{
        didSet {
            if isHighlighted == true {
                UIView.animate(withDuration: 0.5, animations: {
                    self.transform = .init(scaleX: 0.8, y: 0.8)
                })
            } else {
                UIView.animate(withDuration: 0.5, animations: {
                    self.transform = .identity
                })
            }
        }
    }
    func configureCell(categoryItem: CategoriesItem) {
        self.contentView.addSubview(genreImage)
        genreImage.translatesAutoresizingMaskIntoConstraints = false
        genreImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 10).isActive = true
        genreImage.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        genreImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
        genreImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        genreImage.transform = .init(rotationAngle: CGFloat.pi / 8)
        genreImage.loadImage(with: categoryItem.icons[0].url)
        
        self.contentView.addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        textLabel.trailingAnchor.constraint(equalTo: genreImage.leadingAnchor).isActive = true
        textLabel.font = .boldSystemFont(ofSize: 15)
        textLabel.textColor = .white
        textLabel.text = categoryItem.name
        textLabel.numberOfLines = .max
//        textLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10).isActive = true
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
