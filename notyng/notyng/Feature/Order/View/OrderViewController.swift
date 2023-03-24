//
//  OrderViewController.swift
//  notyng
//
//  Created by João Pedro on 23/03/23.
//

import UIKit
import Hero

class OrderViewController: UIViewController {
    
    // MARK: - Variables
    private var closeButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.setTitle("Close", for: .normal)
        button.tintColor = .blue
        button.backgroundColor = .red
        
        return button
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.titleBold64
        label.textAlignment = .left
        label.text = "notyn"
        label.numberOfLines = 0
        label.textColor = Colors.backgroundPrimaryColor
        label.heroID = HeroIds.title
        
        return label
    }()
    
    private var totalValueLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.titleBold24
        label.textAlignment = .right
        label.text = "R$ 999"
        label.numberOfLines = 0
        label.textColor = Colors.backgroundPrimaryColor
        label.heroID = HeroIds.totalPrice
        
        return label
    }()
    
    private var viewBackground: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.backgroundSecondaryColor
        view.layer.cornerRadius = ValueConst.x14
        view.heroID = HeroIds.background
        
        return view
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(
            string: "Insira um nome...",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        )
        textField.font = Fonts.titleBold24
        textField.textColor = Colors.backgroundTertiaryColor
        textField.autocorrectionType = .no
        textField.keyboardType = .namePhonePad
        textField.returnKeyType = .done
        textField.clearButtonMode = .whileEditing
        textField.contentVerticalAlignment = .center
        textField.backgroundColor = .clear
        return textField
    }()
    
    private var textFieldView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.backgroundPrimaryColor
        return view
    }()
    
    private lazy var productsTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        
        return tableView
    }()
    
    private lazy var viewModel: OrderViewModel = {
        let vm = OrderViewModel()
        
        vm.delegate = self
        
        return vm
    }()
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchData()
        
        setupLayout()
        setupLayoutConstraints()
        setupActions()
    }
    
    // MARK: - Layout Setups
    private func setupLayout() {
        view.backgroundColor = Colors.primaryColor
        view.addSubview(closeButton)
        view.addSubview(titleLabel)
        view.addSubview(totalValueLabel)
        view.addSubview(viewBackground)
        viewBackground.addSubview(nameTextField)
        viewBackground.addSubview(textFieldView)
        viewBackground.addSubview(productsTableView)
        
        productsTableView.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.identifier)
    }
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: ValueConst.x8),
            closeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: ValueConst.x8),
            closeButton.heightAnchor.constraint(equalToConstant: ValueConst.x24),
            closeButton.widthAnchor.constraint(equalToConstant: ValueConst.x24),
            
            titleLabel.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: ValueConst.x12),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: ValueConst.x16),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -ValueConst.x16),
            titleLabel.heightAnchor.constraint(equalToConstant: ValueConst.x64),
            
            totalValueLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            totalValueLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -ValueConst.x16),
            totalValueLabel.heightAnchor.constraint(equalToConstant: ValueConst.x48),
            
            viewBackground.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: ValueConst.x8),
            viewBackground.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: ValueConst.x8),
            viewBackground.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: ValueConst.x8),
            viewBackground.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -ValueConst.x8),
            
            nameTextField.topAnchor.constraint(equalTo: viewBackground.topAnchor, constant: ValueConst.x16),
            nameTextField.leadingAnchor.constraint(equalTo: viewBackground.leadingAnchor, constant: ValueConst.x16),
            nameTextField.trailingAnchor.constraint(equalTo: viewBackground.trailingAnchor, constant: -ValueConst.x16),
            
            textFieldView.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            textFieldView.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            textFieldView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: ValueConst.x8),
            textFieldView.heightAnchor.constraint(equalToConstant: ValueConst.x1),
            
            productsTableView.topAnchor.constraint(equalTo: textFieldView.bottomAnchor, constant: ValueConst.x8),
            productsTableView.leadingAnchor.constraint(equalTo: viewBackground.leadingAnchor, constant: ValueConst.x8),
            productsTableView.trailingAnchor.constraint(equalTo: viewBackground.trailingAnchor, constant: -ValueConst.x8),
            productsTableView.bottomAnchor.constraint(equalTo: viewBackground.bottomAnchor, constant: -ValueConst.x8),
        ])
    }
    
    // MARK: - Action Setups
    private func setupActions() {
        closeButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
    }
    
    @objc
    private func dismissView() {
        self.dismiss(animated: true)
    }
}

// MARK: - Extensions
extension OrderViewController: OrderProtocol {
    func fetchTotalValueData(totalValue: String) {
        totalValueLabel.text = totalValue
    }
    
    func fetchTotalValueFailData() {
        totalValueLabel.text = ""
    }
    
    func fetchOrderData() {
        productsTableView.reloadData()
        nameTextField.text = viewModel.order?.name
        nameTextField.isEnabled = false
    }
    
    func fetchOrderFailData() {
        productsTableView.reloadData()
    }
}

extension OrderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.distinctProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier,
                                                       for: indexPath) as? ProductTableViewCell else {return UITableViewCell()}
        
        let product = viewModel.distinctProducts[indexPath.row]
        cell.setupCell(product: product,
                       productCount: viewModel.getCountProducts(product: product))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension OrderViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}