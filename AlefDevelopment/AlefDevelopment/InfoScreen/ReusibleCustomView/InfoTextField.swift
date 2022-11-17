//
//  InfoTextField.swift
//  AlefDevelopment
//
//  Created by pavel mishanin on 26.10.2022.
//

import UIKit

final class InfoTextField: UITextField {
    
    private let titleLabel = UILabel()
    
    private let padding = UIEdgeInsets(top: 25, left: 20, bottom: 0, right: 0)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    init(title: String, keyboardType: UIKeyboardType) {
        super.init(frame: .zero)
        titleLabel.text = title
        self.keyboardType = keyboardType
        
        configAppearance()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Config Appearance
private extension InfoTextField {
    
    func configAppearance() {
        borderStyle = .roundedRect
        autocorrectionType = .no
        
        titleLabel.font = .systemFont(ofSize: 15, weight: .ultraLight)
    }
}

// MARK: - Make Constraints
private extension InfoTextField {
    
    func makeConstraints() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
