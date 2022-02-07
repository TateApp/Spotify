import UIKit
protocol cancelButtonPressed {
    func cancelButtonPressed()
}
class CategoryViewController : UIViewController, UISearchBarDelegate, cancelButtonPressed , getDataIntoPlayerView, getDataIntoPlayer_ViewController  {
    func passBackData(trackID: String) {
        print(trackID)
        protocolVar?.passBackData(trackID: trackID)
    }
    var protocolVar : getDataIntoPlayerView?
    func cancelButtonPressed() {
        UIView.animate(withDuration: 0.5, animations: {
            self.searchController.view.alpha = 0
        })
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        UIView.animate(withDuration: 0.5, animations: {
            self.searchController.view.alpha = 1
           
        })
 
    }
  
    
    let searchController  = SearchViewController()
    private let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { _, _ -> NSCollectionLayoutSection? in
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100)), subitem: item, count: 2)
        group.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        
       
        let section = NSCollectionLayoutSection(group: group)
        let footerHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .absolute(70))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: footerHeaderSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)

        section.boundarySupplementaryItems = [header]
        
        return section
    }  ))
    //MARK : - LifeCycle
  
    var categories : Categories?
    func fetchData () {
        loading.startAnimating()
        let group = DispatchGroup()
        
        group.enter()
        APICaller.shared.getListOfCategories(completion: { result in
         
            switch result {
            case.success(let model):
                DispatchQueue.main.async {
                    self.categories = model
                    self.collectionView.reloadData()
                    self.loading.stopAnimating()
                }
          
            case.failure(let error):
                print("Profile Error: \(error.localizedDescription)")
             
            }
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .init(rbg: 18, green: 18, blue: 18, alpha: 1)
       
      fetchData()
        setupSearchBar()
        setupCollectionView()
        setupSearchController()
        setupLoading()
        
    }
    let loading = UIActivityIndicatorView()
    func setupLoading() {
        self.view.addSubview(loading)
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        loading.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        loading.widthAnchor.constraint(equalToConstant: 100).isActive = true
        loading.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        loading.color =  .white
    
    }
    func setupSearchController() {
        self.addChild(searchController)
        searchController.didMove(toParent: self )
        self.view.addSubview(self.searchController.view)
        searchController.view.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        searchController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        searchController.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        searchController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.searchController.view.alpha = 0
        searchController.protocolVar_1 = self
        searchController.protocolVar = self
        
    }
    let searchTitle = UILabel()
    let cameraButton = UIButton()
    let searchBar = UISearchBar()
    
    func setupSearchBar() {
        self.view.addSubview(searchTitle)
        searchTitle.translatesAutoresizingMaskIntoConstraints = false
        searchTitle.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50).isActive = true
        searchTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        searchTitle.heightAnchor.constraint(equalToConstant: 50).isActive = true
        searchTitle.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        searchTitle.textColor = .white
        searchTitle.text = "Search"
        searchTitle.font = .boldSystemFont(ofSize: 20)
        
        self.view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.topAnchor.constraint(equalTo: searchTitle.bottomAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: searchTitle.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        searchBar.backgroundColor = .clear
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.backgroundColor = .white
        searchBar.placeholder = "Artists, songs or podcasts"
        searchBar.delegate = self
        searchBar.returnKeyType = .done
//        searchBar.searchTextField.delegate = self
    }
    func setupCollectionView () {
       
        //MARK: - First Cell Header
        collectionView.register(CategoryHeaderTop.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "categoryHeaderTop")
        //MARK: - Normal Header
        collectionView.register(CategoryHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "categoryHeader")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(GenreCollectionViewCell.self, forCellWithReuseIdentifier: GenreCollectionViewCell.identifier)
        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor, constant: -40).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        self.view.bringSubviewToFront(searchBar)
        self.view.bringSubviewToFront(searchController.view)
    }
}
extension CategoryViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        searchTitle.transform = .init(translationX: 0, y: 0 - scrollView.contentOffset.y)
        if scrollView.contentOffset.y < 50 {
            searchBar.transform = .init(translationX: 0, y: 0 - scrollView.contentOffset.y)
        }
        if scrollView.contentOffset.y > 50 {
            UIView.animate(withDuration: 0.5, animations: {
                self.searchBar.transform = .init(translationX: 0, y: 0 - 50)
            })
          
        }

    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        APICaller.shared.getCategoryPlaylists(id: categories!.items[indexPath.row].id, completion: { result in 
            switch result {
            case .success(let reponse):
                DispatchQueue.main.async {
                    let vc = CategoryPlaylistViewController(response: reponse, responseTitle:  self.categories!.items[indexPath.row].name)
                    vc.protocolVar = self
                    guard self.navigationController?.topViewController == self else { return }
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let error):
                print(error)
            }
        })
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCollectionViewCell.identifier, for: indexPath) as! GenreCollectionViewCell
        if categories != nil {
            cell.configureCell(categoryItem:  categories!.items[indexPath.row])
        }
      
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
        
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: "categoryHeaderTop", for: indexPath) as! CategoryHeaderTop
       
                headerView.configure(sectionHeader: "Browse All")
                
               
                return headerView
            
          
        } else {
            return UICollectionReusableView()
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if categories?.items != nil {
            return categories!.items.count
        } else {
            return 0
        }
       
    }
    
    
    
}

