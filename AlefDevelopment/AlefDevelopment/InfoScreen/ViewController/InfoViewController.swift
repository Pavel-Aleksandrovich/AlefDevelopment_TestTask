//
//  ViewController.swift
//  AlefDevelopment
//
//  Created by pavel mishanin on 25.10.2022.
//

import UIKit

protocol IInfoViewController: AnyObject {
    func reloadData()
    func hideButton(_ bool: Bool)
    func showAlert()
}

final class InfoViewController: UIViewController {
    
    private let presenter: IInfoPresenter
    private let mainView = InfoMainView()
    private let parentHeaderView = InfoParentHeaderView()
    
    private lazy var childrenFooterView = InfoChildrenFooterView {
        self.presenter.deleteAllTapped()
    }
    
    private lazy var childrenHeaderView = InfoChildrenHeaderView {
        self.presenter.addChildrenTapped()
    }
    
    init(presenter: IInfoPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.onViewAttached(controller: self)
        
        mainView.tableViewDelegate = self
        mainView.tableViewDataSource = self
    }
}

// MARK: - IInfoViewController
extension InfoViewController: IInfoViewController {
    
    func reloadData() {
        mainView.reloadData()
    }
    
    func hideButton(_ bool: Bool) {
        childrenHeaderView.hideButton(bool)
    }
    
    func showAlert() {
        createAlert()
    }
}

// MARK: - TableView Delegate & DataSource
extension InfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        switch presenter.sections[section] {
        case .parent:
            return presenter.parentRows.count
        case .children:
            return presenter.childrenRows.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        presenter.sections.count
    }
    
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        switch presenter.sections[section] {
        case .parent:
            return 50
        case .children:
            return 70
        }
    }
    
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        switch presenter.sections[section] {
        case .parent:
            return parentHeaderView
        case .children:
            return childrenHeaderView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if case .children = presenter.sections[section] {
            return 70
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView,
                   viewForFooterInSection section: Int) -> UIView? {
        if case .children = presenter.sections[section] {
            return childrenFooterView
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: InfoTableCell.id,
            for: indexPath) as? InfoTableCell
        else { return UITableViewCell() }
        
        let type = presenter.sections[indexPath.section]
        
        switch type {
        case .parent:
            cell.setText(presenter.parentRows[indexPath.row])
        case .children:
            cell.onDeleteTappedHandler = {
                self.presenter.deleteChildrenAtIndex(indexPath.row)
            }
            
            cell.setText(presenter.childrenRows[indexPath.row])
        }
        
        cell.setType(type)
        
        cell.textFieldHandler = { model in
            self.presenter.textFieldChanged(model: model, row: indexPath.row, type: type)
        }
        
        return cell
    }
}

// MARK: - Logic
private extension InfoViewController {
    
    func createAlert() {
        let alert = UIAlertController(title: nil,
                                      message: nil,
                                      preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Сбросить данные",
                                         style: .destructive) {_ in
            self.presenter.deleteAll()
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
}
