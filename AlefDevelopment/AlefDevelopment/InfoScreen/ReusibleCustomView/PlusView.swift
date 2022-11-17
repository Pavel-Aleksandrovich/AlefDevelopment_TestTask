//
//  PlusView.swift
//  AlefDevelopment
//
//  Created by pavel mishanin on 27.10.2022.
//

import UIKit

final class PlusView: UIView {
    
    private let textLabel = UILabel()
    private let plusImageView = UIImageView()
    
    private let tapHandler: () -> ()
    
    init(closure: @escaping() -> ()) {
        self.tapHandler = closure
        super.init(frame: .zero)
        configAppearance()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Config Appearance
private extension PlusView {
    
    func configAppearance() {
        configView()
        configTextLabel()
        configPlusImageView()
    }
    
    func configView() {
        backgroundColor = .white
        layer.cornerRadius = 25
        clipsToBounds = true
        layer.borderWidth = 2
        layer.borderColor = Color.lightBlue.color.cgColor
        
        let tapGesture = UITapGestureRecognizer()
        addGestureRecognizer(tapGesture)
        tapGesture.addTarget(self,
                             action: #selector
                             (addTapped))
    }
    
    func configTextLabel() {
        textLabel.text = "Добавить ребенка"
        textLabel.textColor = Color.lightBlue.color
        textLabel.textAlignment = .center
    }
    
    func configPlusImageView() {
        plusImageView.image = UIImage(systemName: "plus")
        plusImageView.contentMode = .scaleAspectFill
        plusImageView.tintColor = Color.lightBlue.color
    }
}

// MARK: - Actions
private extension PlusView {
    
    @objc func addTapped() {
        tapHandler()
    }
}

// MARK: - Make Constraints
private extension PlusView {
    
    func makeConstraints() {
        plusImageViewConstraints()
        textLabelConstraints()
    }
    
    func plusImageViewConstraints() {
        addSubview(plusImageView)
        plusImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            plusImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            plusImageView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            plusImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            plusImageView.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func textLabelConstraints() {
        addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: plusImageView.trailingAnchor, constant: 5),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            textLabel.topAnchor.constraint(equalTo: topAnchor),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
