//
//  ListProductTableViewCell.swift
//  notyng
//
//  Created by João Pedro on 24/03/23.
//

import UIKit

class ListProductTableViewCell: UITableViewCell {
    
    static let identifier = "listProductIdentifier"
    private var productItem = ProductItem(productName: "", productIcon: .soda, productPrice: "")
    
    private var viewBackground: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = ValueConst.x12
        view.backgroundColor = Colors.backgroundPrimaryColor
        
        return view
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
        productItem.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .clear
        contentView.addSubview(viewBackground)
        viewBackground.addSubview(productItem)
    }
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            viewBackground.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ValueConst.x12),
            viewBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -ValueConst.x12),
            viewBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ValueConst.x12),
            viewBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -ValueConst.x12),
            
            productItem.topAnchor.constraint(equalTo: viewBackground.topAnchor, constant: ValueConst.x8),
            productItem.bottomAnchor.constraint(equalTo: viewBackground.bottomAnchor, constant: -ValueConst.x8),
            productItem.leadingAnchor.constraint(equalTo: viewBackground.leadingAnchor, constant: ValueConst.x8),
            productItem.trailingAnchor.constraint(equalTo: viewBackground.trailingAnchor, constant: -ValueConst.x8),
        ])
    }
    
    public func setupCell(product: Product) {
        productItem.name = product.name ?? ""
        productItem.price = product.price.toPriceString()
        productItem.typeIcon = ProductType(rawValue: product.productType) ?? .beer
    }
}
