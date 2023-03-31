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
    
    private var viewBottomDivisor: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.backgroundTertiaryColor
        
        return view
    }()
    
    private var imageBackground: UIImageView = {
        let view = UIImageView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "background_receipt")
        view.heroID = HeroIds.background
        
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
    
    private var viewContent: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
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
        view.addSubview(imageBackground)
        imageBackground.addSubview(viewContent)
        viewContent.addSubview(titleLabel)
        viewContent.addSubview(viewTopDivisor)
        viewContent.addSubview(totalValueLabel)
        viewContent.addSubview(viewBottomDivisor)
        viewContent.addSubview(productsList)
    }
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: ValueConst.x8),
            closeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: ValueConst.x16),
            closeButton.heightAnchor.constraint(equalToConstant: ValueConst.x24),
            closeButton.widthAnchor.constraint(equalToConstant: ValueConst.x24),
            
            imageBackground.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: ValueConst.x8),
            imageBackground.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -ValueConst.x16),
            imageBackground.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: ValueConst.x16),
            imageBackground.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -ValueConst.x16),
            
            viewContent.topAnchor.constraint(equalTo: imageBackground.topAnchor, constant: ValueConst.x64),
            viewContent.bottomAnchor.constraint(equalTo: imageBackground.bottomAnchor, constant: -ValueConst.x64),
            viewContent.leadingAnchor.constraint(equalTo: imageBackground.leadingAnchor),
            viewContent.trailingAnchor.constraint(equalTo: imageBackground.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: viewContent.topAnchor, constant: ValueConst.x12),
            titleLabel.centerXAnchor.constraint(equalTo: viewContent.centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: ValueConst.x64),
            
            viewTopDivisor.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: ValueConst.x8),
            viewTopDivisor.leadingAnchor.constraint(equalTo: viewContent.leadingAnchor, constant: ValueConst.x32),
            viewTopDivisor.trailingAnchor.constraint(equalTo: viewContent.trailingAnchor, constant: -ValueConst.x32),
            viewTopDivisor.heightAnchor.constraint(equalToConstant: 1),
            
            totalValueLabel.bottomAnchor.constraint(equalTo: viewContent.bottomAnchor, constant: -ValueConst.x8),
            totalValueLabel.trailingAnchor.constraint(equalTo: viewContent.trailingAnchor, constant: -ValueConst.x16),
            totalValueLabel.heightAnchor.constraint(equalToConstant: ValueConst.x48),
            
            productsList.topAnchor.constraint(equalTo: viewTopDivisor.bottomAnchor, constant: ValueConst.x8),
            productsList.leadingAnchor.constraint(equalTo: viewContent.leadingAnchor, constant: ValueConst.x8),
            productsList.trailingAnchor.constraint(equalTo: viewContent.trailingAnchor, constant: -ValueConst.x8),
            
            viewBottomDivisor.topAnchor.constraint(equalTo: productsList.bottomAnchor, constant: ValueConst.x8),
            viewBottomDivisor.leadingAnchor.constraint(equalTo: viewContent.leadingAnchor, constant: ValueConst.x32),
            viewBottomDivisor.trailingAnchor.constraint(equalTo: viewContent.trailingAnchor, constant: -ValueConst.x32),
            viewBottomDivisor.bottomAnchor.constraint(equalTo: totalValueLabel.topAnchor, constant: -ValueConst.x8),
            viewBottomDivisor.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
    
    private func setupStackView() {
        
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
