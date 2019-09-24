//
//  CollectionView+Additions.swift
//  IFTTT
//
//  Created by Alexa Francis on 9/23/19.
//  Copyright © 2019 Alexa Francis. All rights reserved.
//

import UIKit

// MARK: - Identifiable Views
public protocol IdentifiableView: class {
    static var identifier: String { get }
}

public extension IdentifiableView where Self: UICollectionReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}

// MARK: - Collection Views

extension UICollectionReusableView: IdentifiableView { }
public extension UICollectionView {
    
    func registerCell<IdentifiableView>(_ cellType: IdentifiableView.Type) where IdentifiableView: UICollectionReusableView {
        self.register(cellType, forCellWithReuseIdentifier: cellType.identifier)
    }
    
    func registerCells<IdentifiableView>(_ cellTypes: IdentifiableView.Type...) where IdentifiableView: UICollectionReusableView {
        for cellType in cellTypes {
            self.registerCell(cellType)
        }
    }
    
    func dequeueCell<IdentifiableView>(_ cellType: IdentifiableView.Type, for indexPath: IndexPath) -> IdentifiableView where IdentifiableView: UICollectionReusableView {
        return self.dequeueReusableCell(withReuseIdentifier: cellType.identifier, for: indexPath) as! IdentifiableView
    }
    
}
