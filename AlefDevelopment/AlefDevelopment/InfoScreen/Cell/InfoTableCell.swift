//
//  InfoTableCell.swift
//  AlefDevelopment
//
//  Created by pavel mishanin on 26.10.2022.
//

import UIKit

final class InfoTableCell: UITableViewCell {
    
    static let id = String(describing: InfoTableCell.self)
    
    private let nameTextField = InfoTextField(title: "Имя", keyboardType: .default)
    private let ageTextField = InfoTextField(title: "Возраст", keyboardType: .numberPad)
    private let vStackView = UIStackView()
    private let deleteLabel = UILabel()
    
    var onDeleteTappedHandler: (() -> ())?
    var textFieldHandler: ((InfoViewModel) -> ())?
    
    private var trailingConstraints = NSLayoutConstraint()
    private let trailingConstant: CGFloat = -20
    
    private var type: InfoSectionType = .parent
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configAppearance()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        switch type {
        case .parent:
            trailingConstraints.constant = trailingConstant
        case .children:
            trailingConstraints.constant = -frame.width/2
        }
    }
}

extension InfoTableCell {
    
    func setType(_ type: InfoSectionType) {
        self.type = type
    }
    
    func setText(_ model: InfoViewModel) {
        nameTextField.text = model.name
        ageTextField.text = model.age
    }
}

// MARK: - Config Appearance
private extension InfoTableCell {
    
    func configAppearance() {
        configView()
        configStackView()
        configDeleteLabel()
        configNameTextField()
        configAgeTextField()
    }
    
    func configView() {
        selectionStyle = .none
    }
    
    func configStackView() {
        vStackView.axis = .vertical
        vStackView.alignment = .center
        vStackView.distribution = .fill
        vStackView.spacing = 10
    }
    
    func configDeleteLabel() {
        deleteLabel.isUserInteractionEnabled = true
        deleteLabel.text = "Удалить"
        deleteLabel.textColor = Color.lightBlue.color
        deleteLabel.textAlignment = .left
        
        let tapGesture = UITapGestureRecognizer()
        deleteLabel.addGestureRecognizer(tapGesture)
        tapGesture.addTarget(self,
                             action: #selector(deleteTapped))
    }
    
    func configNameTextField() {
        nameTextField.addTarget(self,
                                action: #selector(textFieldChanged),
                                for: .editingChanged)
    }
    
    func configAgeTextField() {
        ageTextField.addTarget(self,
                               action: #selector(textFieldChanged),
                               for: .editingChanged)
    }
}

// MARK: - Actions
private extension InfoTableCell {
    
    @objc func textFieldChanged() {
        let name = nameTextField.text
        let age = ageTextField.text
        let model = InfoViewModel(name: name, age: age)
        textFieldHandler?(model)
    }
    
    @objc func deleteTapped() {
        onDeleteTappedHandler?()
    }
}

// MARK: - Make Constraints
private extension InfoTableCell {
    
    func makeConstraints() {
        vStackViewConstraints()
        nameTextFieldConstraints()
        ageTextFieldConstraints()
        deleteLabelConstraints()
    }
    
    func vStackViewConstraints() {
        contentView.addSubview(vStackView)
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            vStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            vStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            vStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        
        trailingConstraints = vStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: trailingConstant)
        trailingConstraints.isActive = true
    }
    
    func nameTextFieldConstraints() {
        vStackView.addArrangedSubview(nameTextField)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameTextField.heightAnchor.constraint(equalToConstant: 60),
            nameTextField.widthAnchor.constraint(equalTo: vStackView.widthAnchor)
        ])
    }
    
    func ageTextFieldConstraints() {
        vStackView.addArrangedSubview(ageTextField)
        ageTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            ageTextField.heightAnchor.constraint(equalToConstant: 60),
            ageTextField.widthAnchor.constraint(equalTo: vStackView.widthAnchor)
        ])
    }
    
    func deleteLabelConstraints() {
        contentView.addSubview(deleteLabel)
        deleteLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            deleteLabel.leadingAnchor.constraint(equalTo: vStackView.trailingAnchor, constant: 20),
            deleteLabel.centerYAnchor.constraint(equalTo: nameTextField.centerYAnchor)
        ])
    }
}
