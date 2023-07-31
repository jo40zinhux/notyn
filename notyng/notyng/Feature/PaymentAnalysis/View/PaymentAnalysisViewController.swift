//
//  PaymentAnalysisViewController.swift
//  notyng
//
//  Created by João Pedro on 02/05/23.
//

import UIKit

class PaymentAnalysisViewController: UIViewController {
    
    // MARK: - Properties
    private var closeButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.tintColor = .white
        button.setBackgroundImage(Icons.close, for: .normal)
        
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
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupLayout()
        setupLayoutConstraints()
    }
    
    // MARK: - Layout Setups
    private func setupLayout() {
        view.backgroundColor = Colors.primaryColor
        view.addSubview(closeButton)
        view.addSubview(viewContent)
        viewContent.addSubview(titleLabel)
    }
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: ValueConst.x8),
            closeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: ValueConst.x16),
            closeButton.heightAnchor.constraint(equalToConstant: ValueConst.x24),
            closeButton.widthAnchor.constraint(equalToConstant: ValueConst.x24),
            
            viewContent.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: ValueConst.x16),
            viewContent.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -ValueConst.x16),
            viewContent.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: ValueConst.x16),
            viewContent.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -ValueConst.x16),
            
            titleLabel.topAnchor.constraint(equalTo: viewContent.topAnchor, constant: ValueConst.x12),
            titleLabel.centerXAnchor.constraint(equalTo: viewContent.centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: ValueConst.x64),
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
