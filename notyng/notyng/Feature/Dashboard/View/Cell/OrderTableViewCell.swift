//
//  OrderTableViewCell.swift
//  notyng
//
//  Created by João Pedro on 20/03/23.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let identifier = "orderIdentifier"
    
    private var viewBackground: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = ValueConst.x12
        view.backgroundColor = Colors.backgroundPrimaryColor
        
        return view
    }()
    
    private var orderTitleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.titleBold24
        label.textAlignment = .left
        label.text = "Fulano de Tal"
        label.numberOfLines = 0
        label.textColor = Colors.backgroundTertiaryColor
        
        return label
    }()
    
    private var orderDateLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.textRegular12
        label.textAlignment = .right
        label.text = Date().formattedDate(format: "dd/MM/yyyy HH:mm")
        label.numberOfLines = 0
        label.textColor = Colors.backgroundTertiaryColor
        
        return label
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
    
    private var orderTotalValue: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.titleBold12
        label.textAlignment = .right
        label.text = "Total R$ ?"
        label.numberOfLines = 0
        label.textColor = Colors.backgroundTertiaryColor
        
        return label
    }()
    
    // MARK: - View LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        setupLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Layout Setups
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupLayout() {
        backgroundColor = .clear
        contentView.addSubview(viewBackground)
        viewBackground.addSubview(orderTitleLabel)
        viewBackground.addSubview(orderDateLabel)
        viewBackground.addSubview(productsList)
        viewBackground.addSubview(orderTotalValue)
    }
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            viewBackground.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ValueConst.x12),
            viewBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -ValueConst.x12),
            viewBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ValueConst.x12),
            viewBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -ValueConst.x12),
            
            orderTitleLabel.topAnchor.constraint(equalTo: viewBackground.topAnchor, constant: ValueConst.x16),
            orderTitleLabel.leadingAnchor.constraint(equalTo: viewBackground.leadingAnchor, constant: ValueConst.x16),
            
            orderDateLabel.topAnchor.constraint(equalTo: viewBackground.topAnchor, constant: ValueConst.x16),
            orderDateLabel.leadingAnchor.constraint(equalTo: orderTitleLabel.trailingAnchor, constant: ValueConst.x8),
            orderDateLabel.trailingAnchor.constraint(equalTo: viewBackground.trailingAnchor, constant: -ValueConst.x16),
            orderDateLabel.widthAnchor.constraint(equalToConstant: ValueConst.x80),
            
            productsList.topAnchor.constraint(equalTo: orderTitleLabel.bottomAnchor, constant: ValueConst.x8),
            productsList.leadingAnchor.constraint(equalTo: viewBackground.leadingAnchor, constant: ValueConst.x16),
            productsList.trailingAnchor.constraint(equalTo: viewBackground.trailingAnchor, constant: -ValueConst.x16),
            
            orderTotalValue.bottomAnchor.constraint(equalTo: viewBackground.bottomAnchor, constant: -ValueConst.x8),
            orderTotalValue.leadingAnchor.constraint(equalTo: viewBackground.leadingAnchor, constant: ValueConst.x16),
            orderTotalValue.trailingAnchor.constraint(equalTo: viewBackground.trailingAnchor, constant: -ValueConst.x16),
            orderTotalValue.topAnchor.constraint(equalTo: productsList.bottomAnchor, constant: ValueConst.x8),
            orderTotalValue.heightAnchor.constraint(equalToConstant: ValueConst.x18)
            
        ])
    }
    
    public func setupCell(name: String, date: Date, products: [Product]) {
        clearStackView()
        orderTitleLabel.text = name
        orderDateLabel.text = date.formattedDate(format: "dd/MM/yyyy HH:mm")
        setupProductsStackView(products: products)
        orderTotalValue.text = setupTotalValue(products: products)
    }
    
    private func clearStackView() {
        productsList.arrangedSubviews
            .filter({ $0 is ProductItem })
            .forEach({ $0.removeFromSuperview() })
    }
    
    private func setupProductsStackView(products: [Product]) {
        let p = getUniqueProducts(products: products)
        for product in p {
            let countSameProducts = products.filter({$0.productId == product.productId}).count
            
            let productName = ProductItem(productName: product.name,
                                          productIcon: ProductType(rawValue: product.productType) ?? .water,
                                          productPrice: "\(countSameProducts)x \(product.price.toPriceString())")
            productName.translatesAutoresizingMaskIntoConstraints = false
            
            productsList.addArrangedSubview(productName)
        }
    }
    
    private func getUniqueProducts(products: [Product]) -> [Product] {
        var uniqueProduct: [Product] = []
        for product in products {
            if !uniqueProduct.contains(where: {$0.productId == product.productId }) {
                uniqueProduct.append(product)
            }
            uniqueProduct = uniqueProduct.sorted(by: {$0.price < $1.price})
        }
        return uniqueProduct
    }
    
    private func setupTotalValue(products: [Product]) -> String {
        var totalValue: Int = 0
        
        for product in products {
            totalValue = totalValue + product.price
        }
        
        return "Total: \(totalValue.toPriceString())"
    }
}
