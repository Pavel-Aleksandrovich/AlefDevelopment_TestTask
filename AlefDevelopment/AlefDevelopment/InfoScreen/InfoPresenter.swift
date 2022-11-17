//
//  InfoPresenter.swift
//  AlefDevelopment
//
//  Created by pavel mishanin on 25.10.2022.
//

import Foundation

protocol IInfoPresenter: AnyObject {
    var sections: [InfoSectionType] { get }
    var childrenRows: [InfoViewModel] { get }
    var parentRows: [InfoViewModel] { get }
    func onViewAttached(controller: IInfoViewController)
    func addChildrenTapped()
    func deleteAllTapped()
    func deleteAll()
    func deleteChildrenAtIndex(_ index: Int)
    func textFieldChanged(model: InfoViewModel, row: Int, type: InfoSectionType)
}

final class InfoPresenter {
    
    private weak var controller: IInfoViewController?
    
    var sections: [InfoSectionType] = InfoSectionType.allCases
    var parentRows = [InfoViewModel()]
    var childrenRows: [InfoViewModel] = [] {
        didSet {
            let bool = childrenRows.count >= 5
            controller?.hideButton(bool)
        }
    }
}

extension InfoPresenter: IInfoPresenter {
    
    func onViewAttached(controller: IInfoViewController) {
        self.controller = controller
    }
    
    func addChildrenTapped() {
        childrenRows.append(InfoViewModel())
        controller?.reloadData()
    }
    
    func deleteAllTapped() {
        controller?.showAlert()
    }
    
    func deleteAll() {
        childrenRows.removeAll()
        parentRows = [InfoViewModel()]
        controller?.reloadData()
    }
    
    func deleteChildrenAtIndex(_ index: Int) {
        childrenRows.remove(at: index)
        controller?.reloadData()
    }
    
    func textFieldChanged(model: InfoViewModel, row: Int, type: InfoSectionType) {
        switch type {
        case .parent:
            parentRows[row] = model
        case .children:
            childrenRows[row] = model
        }
    }
}
