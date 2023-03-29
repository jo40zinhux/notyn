//
//  FloatingButton.swift
//  notyng
//
//  Created by João Pedro on 22/03/23.
//

import Foundation
import UIKit

public final class FloatingButton: UIView {
    
    // MARK: - Properties
    private var viewBackgroundColor: UIColor
    private var iconImage: UIImage?
    private var viewCornerRadius: CGFloat = 12
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = iconImage
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        
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
    init(backgroundColor: UIColor?, iconImage: UIImage?, cornerRadius: CGFloat) {
        self.viewBackgroundColor = backgroundColor ?? .white
        self.iconImage = iconImage
        self.viewCornerRadius = cornerRadius
        
        super.init(frame: .zero)
        
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout Setups
    private func setupView() {
        addSubview(imageView)
        addSubview(interactionButton)
        
        backgroundColor = viewBackgroundColor
        layer.cornerRadius = viewCornerRadius
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            interactionButton.topAnchor.constraint(equalTo: topAnchor),
            interactionButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            interactionButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            interactionButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: ValueConst.x16),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -ValueConst.x16),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: ValueConst.x16),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -ValueConst.x16),
        ])
    }
}
