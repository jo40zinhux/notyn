//
//  MethodTextField.swift
//  notyng
//
//  Created by João Pedro on 10/04/23.
//

import Foundation
import UIKit

public final class MethodTextField: UITextField {
    let arrowImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 14, height: 14))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setLayout()
    }
    
    func setLayout() {
        font = Fonts.textRegular12
        textColor = Colors.backgroundTertiaryColor
        autocorrectionType = .no
        keyboardType = .namePhonePad
        returnKeyType = .done
        clearButtonMode = .whileEditing
        contentVerticalAlignment = .center
        backgroundColor = .clear
        placeholder = "Selecione o método..."
        arrowImage.contentMode = .scaleAspectFit
        arrowImage.image = UIImage(named: "arrow_down")
        arrowImage.isUserInteractionEnabled = false
        arrowImage.tintColor = Colors.primaryColor
        rightViewMode = .always
        setRightImage(arrowImage, padding: 25)
        spellCheckingType = .no
    }
    
    func setRightImage(_ view: UIView, padding: CGFloat) {
        view.translatesAutoresizingMaskIntoConstraints = true

        let outerView = UIView()
        outerView.translatesAutoresizingMaskIntoConstraints = false
        outerView.addSubview(view)

        outerView.frame = CGRect(
            origin: .zero,
            size: CGSize(
                width: view.frame.size.width + padding,
                height: view.frame.size.height + padding
            )
        )

        view.center = CGPoint(
            x: outerView.bounds.size.width / 2,
            y: outerView.bounds.size.height / 2
        )

        rightView = outerView
    }
    
    func showImage() {
        arrowImage.isHidden = false
    }
    
    func hideImage() {
        arrowImage.isHidden = true
    }
}
