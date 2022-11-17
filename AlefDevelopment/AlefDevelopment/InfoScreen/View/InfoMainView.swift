//
//  InfoView.swift
//  AlefDevelopment
//
//  Created by pavel mishanin on 25.10.2022.
//

import UIKit

final class InfoMainView: UIView {
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    private var bottomConstraint = NSLayoutConstraint()
    
    var tableViewDelegate: UITableViewDelegate? {
        get {
            nil
        }
        set {
            self.tableView.delegate = newValue
        }
    }
    
    var tableViewDataSource: UITableViewDataSource? {
        get {
            nil
        }
        set {
            self.tableView.dataSource = newValue
        }
    }
    
    init() {
        super.init(frame: .zero)
        configAppearance()
        makeConstraints()
        hideKeyboardWhenTappedAround()
        registerKeyboardNotification()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension InfoMainView {
    
    func reloadData() {
        tableView.reloadData()
    }
}

// MARK: - Config Appearance
private extension InfoMainView {
    
    func configAppearance() {
        configView()
        configTableView()
    }
    
    func configView() {
        backgroundColor = .white
    }
    
    func configTableView() {
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.register(InfoTableCell.self,
                           forCellReuseIdentifier: InfoTableCell.id)
    }
}

// MARK: - Actions
private extension InfoMainView {
    
    @objc func dismissKeyboard() {
        endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        let userInfo = notification.userInfo
        
        guard let keyboardFrame = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        showKeyboard(keyboardFrame: keyboardFrame)
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        hideKeyboard()
    }
}

// MARK: - Make Constraints
private extension InfoMainView {
    
    func makeConstraints() {
        tableViewConstraints()
    }
    
    func tableViewConstraints() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)
        ])
        
        bottomConstraint = tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        bottomConstraint.isActive = true
    }
}

// MARK: - Logic
private extension InfoMainView {
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        addGestureRecognizer(tap)
    }
    
    func registerKeyboardNotification() {
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    func showKeyboard(keyboardFrame: CGRect) {
        bottomConstraint.constant = -keyboardFrame.height
    }
    
    func hideKeyboard() {
        bottomConstraint.constant = 0
    }
}
