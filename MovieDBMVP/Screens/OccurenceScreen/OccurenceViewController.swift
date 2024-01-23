//
//  OccurenceViewController.swift
//  MovieDBMVP
//
//  Created by Abdullah Onur Şimşek on 22.01.2024.
//

import UIKit

protocol OccurenceViewDisplayLogic: AnyObject {
    func showLoading(isLoading: Bool)
    func display(_ displayData: OccurenceViewDisplayModel)
}

final class OccurenceViewController: BaseViewController {
    typealias Presenter = OccurenceViewPresentationLogic
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .clear
        view.showsVerticalScrollIndicator = false
        view.bounces = false
        view.allowsSelection = false
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    private var presenter: Presenter
    private var displayData: OccurenceViewDisplayModel = .init()
    
    init(presenter: Presenter) {
        self.presenter = presenter
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
        presenter.calculateOccurence()
    }
    
    private func setUI() {
        self.view.backgroundColor = .tmdbDarkBlue
        self.navigationItem.title = "Character Occurence"
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
extension OccurenceViewController: UITableViewDelegate,
                                   UITableViewDataSource {
    private func setupTableView() {
        tableView.separatorInset = .init(top: 0,
                                         left: 20,
                                         bottom: 0,
                                         right: 20)
        tableView.separatorColor = .tmdbLightGreen
        tableView.estimatedRowHeight = 60
        
        tableView.register(TextTableViewCell.self,
                           forCellReuseIdentifier: TextTableViewCell.reuseIdentifier)
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return displayData.getRowCount()
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.reuseIdentifier, for: indexPath) as! TextTableViewCell
        if indexPath.row == 0 {
            cell.populate(with: displayData.getTitle())
        } else {
            cell.populate(with: displayData.getData(at: indexPath.row - 1))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

// MARK: - Display Stuff
extension OccurenceViewController: OccurenceViewDisplayLogic {
    func showLoading(isLoading: Bool) {
        DispatchQueue.main.async {
            isLoading ? self.showProgressHUD() : self.hideProgressHUD()
        }
        
    }
    
    func display(_ displayData: OccurenceViewDisplayModel) {
        self.displayData = displayData
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
}
