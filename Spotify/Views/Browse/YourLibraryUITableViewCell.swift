import UIKit

class YourLibraryUITableViewCell : UITableViewCell {
    static let identifer  = "YourLibraryUITableViewCell"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    var item : MyPlaylistItem?
    
    let apiImageView = CustomImageView()
    let largeTitle = UILabel()
    let smallTitle = UILabel()
    func configureCell(myResponseItem: MyPlaylistItem) {
        item = myResponseItem
        self.contentView.addSubview(apiImageView)
        apiImageView.translatesAutoresizingMaskIntoConstraints = false
        apiImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        apiImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        apiImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        apiImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        apiImageView.loadImage(with: myResponseItem.images.first?.url ?? "")
        apiImageView.backgroundColor = .systemGray3
        
        self.contentView.addSubview(largeTitle)
        largeTitle.translatesAutoresizingMaskIntoConstraints = false
        largeTitle.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: -10).isActive = true
        
        largeTitle.leadingAnchor.constraint(equalTo: self.apiImageView.trailingAnchor, constant: 10).isActive = true
        largeTitle.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        largeTitle.text = item!.name
        largeTitle.font = .boldSystemFont(ofSize: 15)
        largeTitle.textColor = .white
        
        
        self.contentView.addSubview(smallTitle)
        smallTitle.translatesAutoresizingMaskIntoConstraints = false
        smallTitle.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: 10).isActive = true
        smallTitle.leadingAnchor.constraint(equalTo: self.apiImageView.trailingAnchor, constant: 10).isActive = true
        smallTitle.text = "Playlist - \(item!.tracks.total) Songs"
        smallTitle.font = .systemFont(ofSize: 12)
        smallTitle.textColor = .systemGray3
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
