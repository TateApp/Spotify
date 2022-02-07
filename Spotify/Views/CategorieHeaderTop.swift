import UIKit

class CategoryHeaderTop: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        self.backgroundColor = .blue
    }
    let sectionLabel = UILabel()
    
    func configure(sectionHeader: String) {
        self.addSubview(sectionLabel)
        sectionLabel.translatesAutoresizingMaskIntoConstraints = false
    
        sectionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        sectionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        sectionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        sectionLabel.text = sectionHeader
        sectionLabel.textAlignment = .left
        sectionLabel.textColor = .white
        sectionLabel.font = .boldSystemFont(ofSize: 15)
//        self.layer.borderWidth = 1
//        self.layer.borderColor = UIColor.white.cgColor
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
