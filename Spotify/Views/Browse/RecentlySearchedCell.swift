import UIKit
protocol RecentlySearchTableViewCellDeletePressed {
    func deletePressed()
}
class RecentlySearchTableViewCell : UITableViewCell {
    var protocolVar : RecentlySearchTableViewCellDeletePressed?
    static let identifier = "RecentlySearchTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    let apiImageView = CustomImageView()
    let mainLabel = UILabel()
    let deleteButton = UIButton()
    var _response : GetArtistResponse?
    func configureCell(reponse: GetArtistResponse) {
        _response = reponse
        self.contentView.addSubview(apiImageView)
        apiImageView.translatesAutoresizingMaskIntoConstraints = false
        apiImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        apiImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        apiImageView.loadImage(with: reponse.images[0].url)
        apiImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        apiImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        
        self.contentView.addSubview(mainLabel)
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.leadingAnchor.constraint(equalTo: self.apiImageView.trailingAnchor, constant: 10).isActive = true
        mainLabel.centerYAnchor.constraint(equalTo: self.apiImageView.centerYAnchor).isActive = true
        mainLabel.text = reponse.name
        mainLabel.textColor = .white
        mainLabel.font = .boldSystemFont(ofSize: 15)
        
        self.contentView.addSubview(deleteButton)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        deleteButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        deleteButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        deleteButton.setTitle("X", for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteButtonPressed(sender: )), for: .touchUpInside)
    }
    @objc func deleteButtonPressed(sender: UIButton) {
        print("ID Deleted")
        CoreDataManager.shared.deleteID(id: _response!.id)
        protocolVar?.deletePressed()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

