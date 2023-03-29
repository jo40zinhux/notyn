//
//  ProductItem.swift
//  notyng
//
//  Created by João Pedro on 22/03/23.
//

import Foundation
import UIKit

public final class ProductItem: UIView {
    
    // MARK: - Properties
    private var productTitleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.textRegular12
        label.textAlignment = .left
        label.text = ""
        label.numberOfLines = 0
        label.textColor = Colors.backgroundTertiaryColor
        
        return label
    }()
    
    private var productPriceLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.titleBold12
        label.textAlignment = .right
        label.text = ""
        label.numberOfLines = 0
        label.textColor = Colors.backgroundTertiaryColor
        
        return label
    }()
    
    private var productTypeImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Colors.primaryColor
        
        return imageView
    }()
    
    var name = "" {
        didSet {
            productTitleLabel.text = name
        }
    }
    
    var price = "" {
        didSet {
            productPriceLabel.text = price
        }
    }
    
    var typeIcon = ProductType.soda {
        didSet {
            productTypeImage.image = UIImage(named: ProductIcon.getIconNameForType(productType: typeIcon) ?? "")
        }
    }
    
    // MARK: - Init
    init(productName: String, productIcon: ProductType, productPrice: String) {
        productTitleLabel.text = productName
        productPriceLabel.text = productPrice
        productTypeImage.image = UIImage(named: ProductIcon.getIconNameForType(productType: productIcon) ?? "")
        
        super.init(frame: .zero)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout Setups
    private func setupView() {
        addSubview(productTypeImage)
        addSubview(productTitleLabel)
        addSubview(productPriceLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            productTypeImage.topAnchor.constraint(equalTo: topAnchor),
            productTypeImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            productTypeImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            productTypeImage.widthAnchor.constraint(equalToConstant: ValueConst.x24),
            productTypeImage.heightAnchor.constraint(equalToConstant: ValueConst.x24),
            
            productTitleLabel.topAnchor.constraint(equalTo: topAnchor),
            productTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            productTitleLabel.leadingAnchor.constraint(equalTo: productTypeImage.trailingAnchor, constant: ValueConst.x8),
            
            productPriceLabel.topAnchor.constraint(equalTo: topAnchor),
            productPriceLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            productPriceLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            productPriceLabel.widthAnchor.constraint(equalToConstant: ValueConst.x64)
        ])
    }
}
