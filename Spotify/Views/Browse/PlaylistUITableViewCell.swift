import UIKit

class PlaylistUITableViewCell: UITableViewCell {
    static let Identifer = "PlaylistUITableViewCell"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let customImageView = CustomImageView()
    let maintextLabel = UILabel()
    let subTextLabel = UILabel()
    func configure(text: String, subText: String, imageURL: String) {
        self.contentView.addSubview(customImageView)
        customImageView.translatesAutoresizingMaskIntoConstraints  = false
        customImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        customImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        customImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        customImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        customImageView.loadImage(with: imageURL)
        
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
        subTextLabel.text = "Playlist - \(subText)"
        subTextLabel.font = .systemFont(ofSize: 12)
        subTextLabel.textColor = .systemGray3
    }
}
