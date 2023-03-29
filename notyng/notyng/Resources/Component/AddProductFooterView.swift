//
//  AddProductFooterView.swift
//  notyng
//
//  Created by João Pedro on 24/03/23.
//

import UIKit

public final class AddProductFooterView: UIView {
    
    // MARK: - Properties
    private var viewCornerRadius: CGFloat = 12
    
    private var viewContent: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        
        return view
    }()
    
    private var viewBackground: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.backgroundCounter
        
        return view
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.titleBold12
        label.textAlignment = .center
        label.text = "Adicionar um produto"
        label.numberOfLines = 0
        label.textColor = Colors.backgroundTertiaryColor
        
        return label
    }()
    
    private var iconImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Colors.primaryColor
        
        return imageView
    }()
    
    public var interactionButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.setTitle("", for: .normal)
        
        return button
    }()
    
    // MARK: - Init
    init(backgroundColor: UIColor?, iconImage: UIImage?, cornerRadius: CGFloat, frame: CGRect) {
        viewBackground.backgroundColor = backgroundColor
        self.iconImage.image = iconImage
        viewCornerRadius = cornerRadius
        
        super.init(frame: frame)
        
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout Setups
    private func setupView() {
        addSubview(viewContent)
        addSubview(interactionButton)
        viewContent.addSubview(viewBackground)
        viewBackground.addSubview(iconImage)
        viewBackground.addSubview(titleLabel)
        
        viewBackground.backgroundColor = backgroundColor
        viewBackground.layer.cornerRadius = viewCornerRadius
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            viewContent.topAnchor.constraint(equalTo: topAnchor),
            viewContent.bottomAnchor.constraint(equalTo: bottomAnchor),
            viewContent.leadingAnchor.constraint(equalTo: leadingAnchor),
            viewContent.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            interactionButton.topAnchor.constraint(equalTo: topAnchor),
            interactionButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            interactionButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            interactionButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            viewBackground.topAnchor.constraint(equalTo: viewContent.topAnchor, constant: ValueConst.x12),
            viewBackground.bottomAnchor.constraint(equalTo: viewContent.bottomAnchor, constant: -ValueConst.x12),
            viewBackground.leadingAnchor.constraint(equalTo: viewContent.leadingAnchor, constant: ValueConst.x12),
            viewBackground.trailingAnchor.constraint(equalTo: viewContent.trailingAnchor, constant: -ValueConst.x12),
            
            titleLabel.topAnchor.constraint(equalTo: viewBackground.topAnchor, constant: ValueConst.x8),
            titleLabel.bottomAnchor.constraint(equalTo: viewBackground.bottomAnchor, constant: -ValueConst.x8),
            titleLabel.centerXAnchor.constraint(equalTo: viewBackground.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: viewBackground.centerYAnchor),
            
            iconImage.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            iconImage.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            iconImage.trailingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -ValueConst.x24),
            iconImage.widthAnchor.constraint(equalToConstant: ValueConst.x24),
        ])
    }
}
