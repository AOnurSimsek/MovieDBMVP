//
//  HomeViewController.swift
//  MovieDBMVP
//
//  Created by Abdullah Onur Şimşek on 20.01.2024.
//

import UIKit

protocol HomeViewDisplayLogic: AnyObject {
    func showLoading(isLoading: Bool)
    func display(_ displayData: HomeViewDisplayModel)
    func display(_ displayData: [MovieResultResponseModel])
    func display(_ displayData: APIError)
}

final class HomeViewController: BaseViewController {
    typealias Router = HomeViewRoutingLogic
    typealias Presenter = HomeViewPresentationLogic
    
    lazy var searchBar: SearchBarView = {
        let view = SearchBarView(frame: .zero)
        view.setDelegate(delegate: self)
        return view
    }()
    
    private lazy var collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.size.width,
                                              height: .leastNonzeroMagnitude)
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        return flowLayout
    }()

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: self.collectionViewFlowLayout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private var presenter: Presenter
    private var router: Router
    private var displayData: HomeViewDisplayModel = .init()
    var searchText: String? = nil
    
    init(presenter: Presenter,
         router: Router) {
        self.presenter = presenter
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        setUI()
        setLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        hideKeyboardWhenTappedAround()
        presenter.fetchMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavBar()
    }
    
    private func setUI() {
        self.view.backgroundColor = .tmdbDarkBlue
        self.navigationItem.title = ""
    }
    
    private func setNavBar() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setLayout() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(searchBar)
        searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
    
    private func fetchMoreMovies() {
        if let text = searchText {
            presenter.fetchMoreMovies(searchText: text)
        } else {
            presenter.fetchMoreMovies()
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
}

// MARK: - CollectionView Stuff
extension HomeViewController: UICollectionViewDelegate,
                              UICollectionViewDataSource {
    private func setupCollectionView() {
        collectionView.register(MovieCollectionViewCell.self,
                                forCellWithReuseIdentifier: MovieCollectionViewCell.reuseIdentifier)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return displayData.getRowCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, 
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.reuseIdentifier, for: indexPath) as! MovieCollectionViewCell
        cell.populate(with: displayData.getData(at: indexPath.row),
                      delegate: self)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if displayData.getRowCount() - 2 < indexPath.row {
            fetchMoreMovies()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        guard let id = displayData.getData(at: indexPath.row).id
        else { return }
        
        router.routeToDetail(id: id)
    }
    
}

// MARK: - Search Delegates
extension HomeViewController: SearhBarViewDelegate {
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String) {
        let spaceDeletedText = searchText.replacingOccurrences(of: " ", with: "")
        if spaceDeletedText != "" {
            self.searchText = searchText
            presenter.fetchMovies(searchText: searchText)
        } else if searchText == "" {
            self.searchText = nil
            presenter.fetchMovies()
        }
        
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.searchText = nil
        presenter.fetchMovies()
        return true
    }
    
}

// MARK: - Cell Delegates
extension HomeViewController: MovieCollectionViewCellDelegate {
    func didPressCharacterOccurence(title: String) {
        router.routeToOccurence(title: title)
    }
    
}

// MARK: - Display Stuff
extension HomeViewController: HomeViewDisplayLogic {
    func showLoading(isLoading: Bool) {
        DispatchQueue.main.async {
            isLoading ? self.showProgressHUD() : self.hideProgressHUD()
        }
        
    }
    
    func display(_ displayData: HomeViewDisplayModel) {
        self.displayData = displayData
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
    }
    
    func display(_ displayData: [MovieResultResponseModel]) {
        self.displayData.addMoreData(data: displayData)
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
    }
    
    func display(_ displayData: APIError) {
        DispatchQueue.main.async {
            self.router.routeToAlert(alertMessage: displayData.description)
        }
        
    }
    
}
