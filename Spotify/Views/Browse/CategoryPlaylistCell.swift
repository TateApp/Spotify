import UIKit

class CategoryPlaylistCell : UICollectionViewCell {
    static let identifier  = "CategoryPlaylistCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let apiImageView = CustomImageView()
    
    let mainTextLabel = UILabel()
    let subTextLabel = UILabel()
    override var isHighlighted: Bool {
        didSet
        {
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
    func configure(response: CategoryPlaylistItems) {
        self.contentView.addSubview(apiImageView)
        apiImageView.translatesAutoresizingMaskIntoConstraints = false
        apiImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        apiImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        apiImageView.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width / 2) - 40).isActive = true
        apiImageView.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width / 2) - 40).isActive = true
        apiImageView.loadImage(with: response.images.first?.url ?? "")
        
        self.contentView.addSubview(mainTextLabel)
        mainTextLabel.translatesAutoresizingMaskIntoConstraints = false
        mainTextLabel.topAnchor.constraint(equalTo: apiImageView.bottomAnchor, constant: 5).isActive = true
        mainTextLabel.leadingAnchor.constraint(equalTo: apiImageView.leadingAnchor, constant: 5).isActive = true
        mainTextLabel.trailingAnchor.constraint(equalTo: apiImageView.trailingAnchor).isActive = true
        mainTextLabel.text = response.name
        mainTextLabel.font = .boldSystemFont(ofSize: 12)
        mainTextLabel.textColor = .white
    }
}
