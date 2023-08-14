//
//  PaymentOrderViewController.swift
//  notyng
//
//  Created by João Pedro on 31/03/23.
//

import UIKit

class PaymentOrderViewController: UIViewController {
    
    // MARK: - Properties
    private var closeButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.tintColor = .white
        button.setBackgroundImage(Icons.close, for: .normal)
        
        return button
    }()
    
    private var finishButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.tintColor = .white
        button.setBackgroundImage(Icons.confirm, for: .normal)
        
        return button
    }()
    
    private var viewContent: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.backgroundSecondaryColor
        view.layer.cornerRadius = ValueConst.x14
        view.heroID = HeroIds.background
        
        return view
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.titleBold64
        label.textAlignment = .left
        label.text = "notyn"
        label.numberOfLines = 0
        label.textColor = Colors.backgroundTertiaryColor
        label.heroID = HeroIds.title
        
        return label
    }()
    
    private var viewTopDivisor: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.backgroundTertiaryColor
        
        return view
    }()
    
    private var productsList: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.spacing = ValueConst.x8
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private var viewBottomDivisor: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.backgroundTertiaryColor
        
        return view
    }()
    
    private var viewPaymentDivisor: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.backgroundTertiaryColor
        
        return view
    }()
    
    private var totalValueLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.titleBold24
        label.textAlignment = .right
        label.text = "R$ 999"
        label.numberOfLines = 0
        label.textColor = Colors.backgroundTertiaryColor
        label.heroID = HeroIds.totalPrice
        
        return label
    }()
    
    private var paymentMethodView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        
        return view
    }()
    
    private var paymentTitlelabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.titleBold16
        label.textAlignment = .left
        label.text = "Pagamento:"
        label.numberOfLines = 0
        label.textColor = Colors.backgroundTertiaryColor
        label.heroID = HeroIds.totalPrice
        
        return label
    }()
    
    private lazy var paymentMethodTextField: UITextField = {
        let textField = UITextField()
        
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(
            string: "Selecione um método...",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        )
        textField.font = Fonts.textRegular12
        textField.textColor = Colors.backgroundTertiaryColor
        textField.autocorrectionType = .no
        textField.keyboardType = .namePhonePad
        textField.returnKeyType = .done
        textField.contentVerticalAlignment = .center
        textField.backgroundColor = .clear
        textField.textAlignment = .right
        
        return textField
    }()
    
    private lazy var paymentMethodPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        return pickerView
    }()
    
    public lazy var viewModel: PaymentOrderViewModel = {
        let viewModel = PaymentOrderViewModel()
        
        viewModel.delegate = self
        
        return viewModel
    }()
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupLayout()
        setupLayoutConstraints()
        setupStackView()
        setupActions()
    }
    
    // MARK: - Layout Setups
    private func setupLayout() {
        view.backgroundColor = Colors.primaryColor
        view.addSubview(closeButton)
        view.addSubview(finishButton)
        view.addSubview(viewContent)
        viewContent.addSubview(titleLabel)
        viewContent.addSubview(viewTopDivisor)
        viewContent.addSubview(productsList)
        viewContent.addSubview(viewBottomDivisor)
        viewContent.addSubview(totalValueLabel)
        viewContent.addSubview(viewPaymentDivisor)
        viewContent.addSubview(paymentMethodView)
        paymentMethodView.addSubview(paymentTitlelabel)
        paymentMethodView.addSubview(paymentMethodTextField)
        
        finishButton.isHidden = true
        finishButton.isEnabled = false
        
        paymentMethodTextField.inputView = paymentMethodPickerView
    }
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: ValueConst.x8),
            closeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: ValueConst.x16),
            closeButton.heightAnchor.constraint(equalToConstant: ValueConst.x24),
            closeButton.widthAnchor.constraint(equalToConstant: ValueConst.x24),
            
            finishButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: ValueConst.x8),
            finishButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -ValueConst.x16),
            finishButton.heightAnchor.constraint(equalToConstant: ValueConst.x24),
            finishButton.widthAnchor.constraint(equalToConstant: ValueConst.x24),
            
            viewContent.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: ValueConst.x16),
            viewContent.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -ValueConst.x16),
            viewContent.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: ValueConst.x16),
            viewContent.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -ValueConst.x16),
            
            paymentMethodView.bottomAnchor.constraint(equalTo: viewContent.bottomAnchor, constant: -ValueConst.x8),
            paymentMethodView.leadingAnchor.constraint(equalTo: viewContent.leadingAnchor, constant: ValueConst.x32),
            paymentMethodView.trailingAnchor.constraint(equalTo: viewContent.trailingAnchor, constant: -ValueConst.x32),
            paymentMethodView.heightAnchor.constraint(equalToConstant: ValueConst.x64),
            
            paymentTitlelabel.topAnchor.constraint(equalTo: paymentMethodView.topAnchor),
            paymentTitlelabel.bottomAnchor.constraint(equalTo: paymentMethodView.bottomAnchor),
            paymentTitlelabel.leadingAnchor.constraint(equalTo: paymentMethodView.leadingAnchor),
            paymentTitlelabel.widthAnchor.constraint(equalToConstant: ValueConst.x128),
            
            paymentMethodTextField.topAnchor.constraint(equalTo: paymentTitlelabel.topAnchor),
            paymentMethodTextField.bottomAnchor.constraint(equalTo: paymentTitlelabel.bottomAnchor),
            paymentMethodTextField.leadingAnchor.constraint(equalTo: paymentTitlelabel.trailingAnchor, constant: ValueConst.x8),
            paymentMethodTextField.trailingAnchor.constraint(equalTo: paymentMethodView.trailingAnchor),
            
            viewPaymentDivisor.bottomAnchor.constraint(equalTo: paymentMethodView.topAnchor, constant: -ValueConst.x8),
            viewPaymentDivisor.leadingAnchor.constraint(equalTo: viewContent.leadingAnchor, constant: ValueConst.x32),
            viewPaymentDivisor.trailingAnchor.constraint(equalTo: viewContent.trailingAnchor, constant: -ValueConst.x32),
            viewPaymentDivisor.heightAnchor.constraint(equalToConstant: 1),
            
            totalValueLabel.bottomAnchor.constraint(equalTo: viewPaymentDivisor.topAnchor, constant: -ValueConst.x8),
            totalValueLabel.leadingAnchor.constraint(equalTo: viewPaymentDivisor.leadingAnchor),
            totalValueLabel.trailingAnchor.constraint(equalTo: viewPaymentDivisor.trailingAnchor),
            totalValueLabel.heightAnchor.constraint(equalToConstant: ValueConst.x64),
            
            viewBottomDivisor.bottomAnchor.constraint(equalTo: totalValueLabel.topAnchor, constant: -ValueConst.x8),
            viewBottomDivisor.leadingAnchor.constraint(equalTo: viewPaymentDivisor.leadingAnchor),
            viewBottomDivisor.trailingAnchor.constraint(equalTo: viewPaymentDivisor.trailingAnchor),
            viewBottomDivisor.heightAnchor.constraint(equalToConstant: 1),
            
            productsList.bottomAnchor.constraint(equalTo: viewBottomDivisor.topAnchor, constant: -ValueConst.x16),
            productsList.leadingAnchor.constraint(equalTo: viewPaymentDivisor.leadingAnchor),
            productsList.trailingAnchor.constraint(equalTo: viewPaymentDivisor.trailingAnchor),
            
            viewTopDivisor.bottomAnchor.constraint(equalTo: productsList.topAnchor, constant: -ValueConst.x8),
            viewTopDivisor.leadingAnchor.constraint(equalTo: viewPaymentDivisor.leadingAnchor),
            viewTopDivisor.trailingAnchor.constraint(equalTo: viewPaymentDivisor.trailingAnchor),
            viewTopDivisor.heightAnchor.constraint(equalToConstant: 1),
            
            titleLabel.topAnchor.constraint(equalTo: viewContent.topAnchor, constant: ValueConst.x12),
            titleLabel.centerXAnchor.constraint(equalTo: viewContent.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: viewTopDivisor.topAnchor, constant: -ValueConst.x8),
            titleLabel.heightAnchor.constraint(equalToConstant: ValueConst.x64),
        ])
    }
    
    private func setupStackView() {
        self.clearStackView()
        viewModel.setupProductsStackView()
    }
    
    private func clearStackView() {
        productsList.arrangedSubviews
            .filter({ $0 is ProductItem })
            .forEach({ $0.removeFromSuperview() })
    }
    
    // MARK: - Action Setups
    private func setupActions() {
        closeButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        finishButton.addTarget(self, action: #selector(finishOrder), for: .touchUpInside)
    }
    
    @objc
    private func dismissView() {
        self.dismiss(animated: true)
    }
    
    @objc
    private func finishOrder() {
        print("go to select method payment type")
        viewModel.saveOrder()
    }
}

// MARK: - Extensions
extension PaymentOrderViewController: PaymentOrderProtocol {
    func fetchSaveOrder() {
        self.view.window?.rootViewController?.dismiss(animated: true)
        self.view.window?.rootViewController = DashboardViewController()
    }
    
    func fetchSaveFailOrder() {
        print("fail save")
    }
    
    func fetchTotalValue(totalValue: String) {
        totalValueLabel.text = totalValue
    }
    
    func fetchStackView(views: [ProductItem]) {
        for v in views {
            productsList.addArrangedSubview(v)
        }
    }
}

extension PaymentOrderViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if paymentMethodTextField.text == "" {
            paymentMethodTextField.text = MethodIcon.getNameFromMethodType(method: .pix)
            viewModel.selectedMethod = .pix
        }
        
        return true
    }
}

extension PaymentOrderViewController : UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.methods.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        finishButton.isHidden = false
        finishButton.isEnabled = true
        return MethodIcon.getNameFromMethodType(method: viewModel.methods[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        paymentMethodTextField.text = MethodIcon.getNameFromMethodType(method: viewModel.methods[row])
        viewModel.selectedMethod = viewModel.methods[row]
        
        finishButton.isHidden = false
        finishButton.isEnabled = true
    }
}
