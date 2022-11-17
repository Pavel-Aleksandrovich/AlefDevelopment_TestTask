//
//  InfoHeaderView.swift
//  AlefDevelopment
//
//  Created by pavel mishanin on 26.10.2022.
//

import UIKit

final class InfoParentHeaderView: UIView {
    
    private let titleLabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        configAppearance()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Config Appearance
private extension InfoParentHeaderView {
    
    func configAppearance() {
        titleLabel.text = "Персональные данные"
        titleLabel.font = .systemFont(ofSize: 18)
    }
}

// MARK: - Make Constraints
private extension InfoParentHeaderView {
    
    func makeConstraints() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
