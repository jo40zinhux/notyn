//
//  LoaderView.swift
//  notyng
//
//  Created by João Pedro on 25/04/23.
//

import UIKit

public final class LoaderView: UIView {
    
    // MARK: - Properties
    private var spinningLoader: UIActivityIndicatorView = {
        let spinning = UIActivityIndicatorView(style: .large)
        
        spinning.translatesAutoresizingMaskIntoConstraints = false
        
        return spinning
    }()
    
    // MARK: - Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout Setups
    private func setupView() {
        backgroundColor = UIColor(white: 0, alpha: 0.7)
        addSubview(spinningLoader)
        spinningLoader.startAnimating()
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            spinningLoader.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinningLoader.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
