//
//  ListProductViewController.swift
//  notyng
//
//  Created by João Pedro on 24/03/23.
//

import UIKit

class ListProductViewController: UIViewController {
    
    // MARK: - Properties
    var delegate: ProductProtocol? = nil
    
    private lazy var listProductTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = Colors.backgroundSecondaryColor
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    private lazy var viewModel: ListProductViewModel = {
        let vm = ListProductViewModel()
        
        vm.delegate = self
        
        return vm
    }()
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = Colors.backgroundSecondaryColor
        
        viewModel.fetchData()
        setupLayout()
        setupLayoutConstraints()
    }
    
    // MARK: - Laytou Setups
    private func setupLayout() {
        view.addSubview(listProductTableView)
        
        listProductTableView.register(ListProductTableViewCell.self, forCellReuseIdentifier: ListProductTableViewCell.identifier)
    }
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            listProductTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            listProductTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            listProductTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            listProductTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}

// MARK: - Extensions
extension ListProductViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListProductTableViewCell.identifier,
                                                       for: indexPath) as? ListProductTableViewCell else {return UITableViewCell()}
        let p = viewModel.products[indexPath.row]
        cell.setupCell(product: p)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.selectedProduct(product: viewModel.products[indexPath.row])
        
        self.dismiss(animated: true)
    }
}

extension ListProductViewController: ListProductProtocol {
    func fetchData() {
        listProductTableView.reloadData()
    }
    
    func fetchFailData() {
        listProductTableView.reloadData()
    }
}
