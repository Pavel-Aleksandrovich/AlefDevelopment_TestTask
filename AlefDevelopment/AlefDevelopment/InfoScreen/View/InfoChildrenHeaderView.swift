//
//  InfoChildrenHeaderView.swift
//  AlefDevelopment
//
//  Created by pavel mishanin on 25.10.2022.
//

import UIKit

final class InfoChildrenHeaderView: UIView {
    
    private let titleLabel = UILabel()
    private lazy var addChildrenView = PlusView { self.addChildrenTapped() }
    
    private let addChildrenTapped: () -> ()
    
    init(closure: @escaping() -> ()) {
        self.addChildrenTapped = closure
        super.init(frame: .zero)
        configAppearance()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        checkWhenLabelIsFull()
    }
}

extension InfoChildrenHeaderView {
    
    func hideButton(_ bool: Bool) {
        addChildrenView.isHidden = bool
    }
}

// MARK: - Config Appearance
private extension InfoChildrenHeaderView {
    
    func configAppearance() {
        titleLabel.text = "Дети (макс. 5)"
        titleLabel.font = .systemFont(ofSize: 18)
    }
}

// MARK: - Make Constraints
private extension InfoChildrenHeaderView {
    
    func makeConstraints() {
        addChildrenViewConstraints()
        titleLabelConstraints()
    }
    
    func addChildrenViewConstraints() {
        addSubview(addChildrenView)
        addChildrenView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addChildrenView.widthAnchor.constraint(equalToConstant: 210),
            addChildrenView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            addChildrenView.heightAnchor.constraint(equalToConstant: 50),
            addChildrenView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func titleLabelConstraints() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.trailingAnchor.constraint(equalTo: addChildrenView.leadingAnchor, constant: -5),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: - Logic
private extension InfoChildrenHeaderView {
    
    func checkWhenLabelIsFull() {
        if titleLabel.frame.width < titleLabel.intrinsicContentSize.width {
            titleLabel.text = "Макс. 5"
        }
    }
}
