//
//  DetailViewController.swift
//  MovieDBMVP
//
//  Created by Abdullah Onur Şimşek on 22.01.2024.
//

import UIKit

protocol DetailViewDisplayLogic: AnyObject {
    func showLoading(isLoading: Bool)
    func display(_ displayData: DetailViewDisplayModel)
    func display(_ displayData: APIError)
}

final class DetailViewController: BaseViewController {
    typealias Router = DetailViewRoutingLogic
    typealias Presenter = DetailViewPresentationLogic
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .clear
        view.showsVerticalScrollIndicator = false
        view.bounces = false
        return view
    }()
    
    private var presenter: Presenter
    private var router: Router
    private var displayData: DetailViewDisplayModel = .init()
    
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
        setupTableView()
        presenter.fetchMovieDetail()
    }
    
    private func setUI() {
        self.view.backgroundColor = .tmdbDarkBlue
        self.navigationItem.title = "Movie Detail"
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func setLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
    
}

// MARK: - TableView Stuff
extension DetailViewController: UITableViewDelegate,
                                UITableViewDataSource {
    private func setupTableView() {
        tableView.separatorInset = .init(top: 0,
                                         left: 20,
                                         bottom: 0,
                                         right: 20)
        tableView.separatorColor = .tmdbLightGreen
        tableView.estimatedRowHeight = 60
        
        tableView.register(InformationTableViewCell.self,
                           forCellReuseIdentifier: InformationTableViewCell.reuseIdentifier)
        tableView.register(ImageTableViewCell.self,
                           forCellReuseIdentifier: ImageTableViewCell.reuseIdentifier)
        tableView.register(ButtonTableViewCell.self,
                           forCellReuseIdentifier: ButtonTableViewCell.reuseIdentifier)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return displayData.getSectionCount()
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return displayData.getRowCount()
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentSection = displayData.getSectionType(at: indexPath.section)
        let cellData = displayData.getCellData(type: currentSection)
        
        switch currentSection {
        case .imageAndTitle:
            let cell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.reuseIdentifier,
                                                     for: indexPath) as! ImageTableViewCell
            cell.populate(with: cellData)
            return cell
            
        case .overview:
            let cell = tableView.dequeueReusableCell(withIdentifier: InformationTableViewCell.reuseIdentifier,
                                                     for: indexPath) as! InformationTableViewCell
            cell.populate(with: cellData)
            return cell
            
        case .genre:
            let cell = tableView.dequeueReusableCell(withIdentifier: InformationTableViewCell.reuseIdentifier,
                                                     for: indexPath) as! InformationTableViewCell
            cell.populate(with: cellData)
            return cell
            
        case .vote:
            let cell = tableView.dequeueReusableCell(withIdentifier: InformationTableViewCell.reuseIdentifier,
                                                     for: indexPath) as! InformationTableViewCell
            cell.populate(with: cellData)
            return cell
            
        case .releaseDate:
            let cell = tableView.dequeueReusableCell(withIdentifier: InformationTableViewCell.reuseIdentifier,
                                                     for: indexPath) as! InformationTableViewCell
            cell.populate(with: cellData)
            return cell
            
        case .imdbButton:
            let cell = tableView.dequeueReusableCell(withIdentifier: ButtonTableViewCell.reuseIdentifier,
                                                     for: indexPath) as! ButtonTableViewCell
            cell.populate(with: cellData)
            return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        let currentSection = displayData.getSectionType(at: indexPath.section)
        
        switch currentSection {
        case .imdbButton:
            guard let imdbId = displayData.getImdbId()
            else { return }
            
            router.routeToIMDB(imdbId: imdbId)
            
        default:
            return
            
        }
        
    }
    
}

// MARK: - Display Stuff
extension DetailViewController: DetailViewDisplayLogic {
    func showLoading(isLoading: Bool) {
        DispatchQueue.main.async {
            isLoading ? self.showProgressHUD() : self.hideProgressHUD()
        }
        
    }
    
    func display(_ displayData: DetailViewDisplayModel) {
        self.displayData = displayData
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    func display(_ displayData: APIError) {
        DispatchQueue.main.async {
            self.router.routeToAlert(alertMessage: displayData.description)
        }
        
    }
    
}

