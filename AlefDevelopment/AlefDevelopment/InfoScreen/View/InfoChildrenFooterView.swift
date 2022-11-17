//
//  InfoChildrenFooterView.swift
//  AlefDevelopment
//
//  Created by pavel mishanin on 25.10.2022.
//

import UIKit

final class InfoChildrenFooterView: UIView {
    
    private let deleteView = UIView()
    private let textLabel = UILabel()
    
    private let onViewTapped: () -> ()
    
    init(closure: @escaping() -> ()) {
        self.onViewTapped = closure
        super.init(frame: .zero)
        makeConstraints()
        configAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Config Appearance
private extension InfoChildrenFooterView {
    
    func configAppearance() {
        configdeleteView()
        configTextLabel()
    }
    
    func configdeleteView() {
        deleteView.backgroundColor = .white
        deleteView.layer.cornerRadius = 25
        deleteView.clipsToBounds = true
        deleteView.layer.borderWidth = 2
        deleteView.layer.borderColor = Color.red.color.cgColor
        
        let tapGesture = UITapGestureRecognizer()
        deleteView.addGestureRecognizer(tapGesture)
        tapGesture.addTarget(self,
                             action: #selector
                             (viewTapped))
    }
    
    func configTextLabel() {
        textLabel.text = "Очистить"
        textLabel.textColor = Color.red.color
        textLabel.textAlignment = .center
    }
}

// MARK: - Actions
private extension InfoChildrenFooterView {
    
    @objc func viewTapped() {
        onViewTapped()
    }
}

// MARK: - Make Constraints
private extension InfoChildrenFooterView {
    
    func makeConstraints() {
        deleteViewConstraints()
        textLabelConstraints()
    }
    
    func deleteViewConstraints() {
        addSubview(deleteView)
        deleteView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            deleteView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 80),
            deleteView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -80),
            deleteView.heightAnchor.constraint(equalToConstant: 50),
            deleteView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    func textLabelConstraints() {
        deleteView.addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: deleteView.leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: deleteView.trailingAnchor),
            textLabel.centerXAnchor.constraint(equalTo: deleteView.centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: deleteView.centerYAnchor)
        ])
    }
}
