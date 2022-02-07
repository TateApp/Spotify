import UIKit

class ArtistUITableViewCell: UITableViewCell {
    static let Identifer = "ArtistUITableViewCell"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let maintextLabel = UILabel()
    let subTextLabel = UILabel()
    let customImageView = CustomImageView()
    
    func configure(text: String, subText: String, imageURL: String) {
        self.contentView.addSubview(customImageView)
        customImageView.translatesAutoresizingMaskIntoConstraints  = false
        customImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        customImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        customImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        customImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        customImageView.loadImage(with: imageURL)
        customImageView.layer.cornerRadius = 20
        customImageView.layer.masksToBounds = true
        self.accessoryType = .disclosureIndicator
        self.contentView.addSubview(maintextLabel)
        maintextLabel.translatesAutoresizingMaskIntoConstraints = false
        maintextLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: -10).isActive = true
        maintextLabel.leadingAnchor.constraint(equalTo: self.customImageView.trailingAnchor, constant: 10).isActive = true
        maintextLabel.text = text
        maintextLabel.font = .boldSystemFont(ofSize: 15)
        maintextLabel.textColor = .white
        
        self.contentView.addSubview(subTextLabel)
        subTextLabel.translatesAutoresizingMaskIntoConstraints = false
        subTextLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: 10).isActive = true
        
        subTextLabel.leadingAnchor.constraint(equalTo: self.customImageView.trailingAnchor, constant: 10).isActive = true
        subTextLabel.text = "Artist - \(subText)"
        subTextLabel.font = .systemFont(ofSize: 12)
        subTextLabel.textColor = .systemGray3
    }
}
