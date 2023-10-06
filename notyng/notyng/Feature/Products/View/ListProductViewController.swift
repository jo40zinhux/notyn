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
    
    private var searchContentView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.backgroundPrimaryColor
        view.layer.cornerRadius = ValueConst.x14
        
        return view
    }()
    
    private lazy var filterProductsTextField: UITextField = {
        let textField = UITextField()
        
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(
            string: "Produto...",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        )
        textField.font = Fonts.textRegular12
        textField.textColor = Colors.backgroundTertiaryColor
        textField.autocorrectionType = .no
        textField.keyboardType = .namePhonePad
        textField.returnKeyType = .done
        textField.contentVerticalAlignment = .center
        textField.backgroundColor = .clear
        textField.textAlignment = .left
        textField.clearButtonMode = .whileEditing
        
        return textField
    }()
    
    private var searchImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Icons.search
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Colors.primaryColor
        
        return imageView
    }()
    
    private lazy var listProductTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
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
        view.addSubview(searchContentView)
        view.addSubview(listProductTableView)
        searchContentView.addSubview(filterProductsTextField)
        searchContentView.addSubview(searchImage)
        
        listProductTableView.register(ListProductTableViewCell.self, forCellReuseIdentifier: ListProductTableViewCell.identifier)
    }
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            searchContentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: ValueConst.x16),
            searchContentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: ValueConst.x16),
            searchContentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -ValueConst.x16),
            searchContentView.heightAnchor.constraint(equalToConstant: ValueConst.x48),

            searchImage.centerYAnchor.constraint(equalTo: searchContentView.centerYAnchor),
            searchImage.leadingAnchor.constraint(equalTo: searchContentView.leadingAnchor, constant: ValueConst.x16),
            searchImage.heightAnchor.constraint(equalToConstant: ValueConst.x28),
            searchImage.widthAnchor.constraint(equalToConstant: ValueConst.x28),

            filterProductsTextField.centerYAnchor.constraint(equalTo: searchImage.centerYAnchor),
            filterProductsTextField.leadingAnchor.constraint(equalTo: searchImage.trailingAnchor, constant: ValueConst.x8),
            filterProductsTextField.trailingAnchor.constraint(equalTo: searchContentView.trailingAnchor),
            
            listProductTableView.topAnchor.constraint(equalTo: searchContentView.bottomAnchor, constant: ValueConst.x8),
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

extension ListProductViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text != "" {
            let value = textField.text ?? ""
            viewModel.filterProductByName(name: value)
        } else {
            viewModel.clearFilter()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
