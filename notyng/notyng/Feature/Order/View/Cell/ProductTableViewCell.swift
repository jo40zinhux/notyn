//
//  ProductTableViewCell.swift
//  notyng
//
//  Created by João Pedro on 23/03/23.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let identifier = "productIdentifier"
    private var productItem = ProductItem(productName: "", productIcon: .soda, productPrice: "")
    private var mProduct: Product?
    public var delegate: ProductCellProtocol?
    
    private var viewBackground: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = ValueConst.x12
        view.backgroundColor = Colors.backgroundPrimaryColor
        
        return view
    }()
    
    private var counterBackground: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = ValueConst.x12
        view.backgroundColor = Colors.backgroundCounter
        
        return view
    }()
    
    private var counterLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.titleBold16
        label.textAlignment = .center
        label.text = "1"
        label.numberOfLines = 0
        label.textColor = Colors.backgroundTertiaryColor
        
        return label
    }()
    
    private var counterPlusImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Icons.addProduct
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Colors.primaryColor
        
        return imageView
    }()
    
    private var counterMinusImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Icons.removeProduct
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Colors.primaryColor
        
        return imageView
    }()
    
    private var minusButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.setTitle("", for: .normal)
        
        return button
    }()
    
    private var plusButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.setTitle("", for: .normal)
        
        return button
    }()
    
    var productCount = 0 {
        didSet {
            counterLabel.text = "\(productCount)"
        }
    }
    
    // MARK: - View LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        setupLayoutConstraints()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Layout Setups
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupLayout() {
        productItem.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .clear
        contentView.addSubview(viewBackground)
        viewBackground.addSubview(productItem)
        viewBackground.addSubview(counterBackground)
        counterBackground.addSubview(counterLabel)
        counterBackground.addSubview(counterPlusImage)
        counterBackground.addSubview(counterMinusImage)
        counterBackground.addSubview(plusButton)
        counterBackground.addSubview(minusButton)
    }
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            viewBackground.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ValueConst.x12),
            viewBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -ValueConst.x12),
            viewBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ValueConst.x12),
            viewBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -ValueConst.x12),
            
            counterBackground.topAnchor.constraint(equalTo: viewBackground.topAnchor, constant: ValueConst.x8),
            counterBackground.trailingAnchor.constraint(equalTo: viewBackground.trailingAnchor, constant: -ValueConst.x8),
            counterBackground.bottomAnchor.constraint(equalTo: viewBackground.bottomAnchor, constant: -ValueConst.x8),
            counterBackground.widthAnchor.constraint(equalToConstant: ValueConst.x140),
            counterBackground.heightAnchor.constraint(equalToConstant: ValueConst.x48),
            
            productItem.topAnchor.constraint(equalTo: viewBackground.topAnchor, constant: ValueConst.x8),
            productItem.bottomAnchor.constraint(equalTo: viewBackground.bottomAnchor, constant: -ValueConst.x8),
            productItem.leadingAnchor.constraint(equalTo: viewBackground.leadingAnchor, constant: ValueConst.x8),
            productItem.trailingAnchor.constraint(equalTo: counterBackground.leadingAnchor, constant: -ValueConst.x12),
            
            counterPlusImage.topAnchor.constraint(equalTo: counterBackground.topAnchor, constant: ValueConst.x8),
            counterPlusImage.bottomAnchor.constraint(equalTo: counterBackground.bottomAnchor, constant: -ValueConst.x8),
            counterPlusImage.trailingAnchor.constraint(equalTo: counterBackground.trailingAnchor, constant: -ValueConst.x8),
            counterPlusImage.widthAnchor.constraint(equalToConstant: ValueConst.x24),
            
            counterMinusImage.topAnchor.constraint(equalTo: counterBackground.topAnchor, constant: ValueConst.x8),
            counterMinusImage.bottomAnchor.constraint(equalTo: counterBackground.bottomAnchor, constant: -ValueConst.x8),
            counterMinusImage.leadingAnchor.constraint(equalTo: counterBackground.leadingAnchor, constant: ValueConst.x8),
            counterMinusImage.widthAnchor.constraint(equalToConstant: ValueConst.x24),
            
            plusButton.topAnchor.constraint(equalTo: counterBackground.topAnchor, constant: ValueConst.x8),
            plusButton.bottomAnchor.constraint(equalTo: counterBackground.bottomAnchor, constant: -ValueConst.x8),
            plusButton.trailingAnchor.constraint(equalTo: counterBackground.trailingAnchor, constant: -ValueConst.x8),
            plusButton.widthAnchor.constraint(equalToConstant: ValueConst.x24),
            
            minusButton.topAnchor.constraint(equalTo: counterBackground.topAnchor, constant: ValueConst.x8),
            minusButton.bottomAnchor.constraint(equalTo: counterBackground.bottomAnchor, constant: -ValueConst.x8),
            minusButton.leadingAnchor.constraint(equalTo: counterBackground.leadingAnchor, constant: ValueConst.x8),
            minusButton.widthAnchor.constraint(equalToConstant: ValueConst.x24),
            
            counterLabel.topAnchor.constraint(equalTo: counterBackground.topAnchor, constant: ValueConst.x8),
            counterLabel.leadingAnchor.constraint(equalTo: counterMinusImage.trailingAnchor, constant: ValueConst.x8),
            counterLabel.bottomAnchor.constraint(equalTo: counterBackground.bottomAnchor, constant: -ValueConst.x8),
            counterLabel.trailingAnchor.constraint(equalTo: counterPlusImage.leadingAnchor, constant: -ValueConst.x8),
        ])
    }
    
    public func setupCell(product: Product, productCount: Int) {
        mProduct = product
        productItem.typeIcon = ProductType(rawValue: product.productType) ?? .soda
        productItem.price = product.price.toPriceString()
        productItem.name = product.name 
        self.productCount = productCount
        
        counterBackground.isHidden = false
        minusButton.isEnabled = true
        plusButton.isEnabled = true
    }
    
    // MARK: - Action Setups
    private func setupActions() {
        plusButton.addTarget(self, action: #selector(addCounterProduct), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(removeCounterProduct), for: .touchUpInside)
    }
    
    @objc
    private func addCounterProduct() {
        productCount += 1
        if let product = mProduct {
            delegate?.addSelectedProduct(product: product)
        }
    }
    
    @objc
    private func removeCounterProduct() {
        if productCount > 0 {
            productCount -= 1
            if let product = mProduct {
                delegate?.removeSelectedProduct(product: product)
            }
        }
    }
}

protocol ProductCellProtocol {
    func removeSelectedProduct(product: Product)
    func addSelectedProduct(product: Product)
}
