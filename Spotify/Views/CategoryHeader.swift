import UIKit

class CategoryHeader: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        self.backgroundColor = .blue
    }
    let sectionLabel = UILabel()
    
    func configure(sectionHeader: String) {
        self.addSubview(sectionLabel)
        sectionLabel.translatesAutoresizingMaskIntoConstraints = false
        sectionLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        sectionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        sectionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        sectionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        sectionLabel.text = sectionHeader
        sectionLabel.textAlignment = .left
        sectionLabel.textColor = .white
        sectionLabel.font = .boldSystemFont(ofSize: 12)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
