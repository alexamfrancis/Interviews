//
//  TriggerCollectionViewController.swift
//  Applet IFTTT
//
//  Created by Alexa Francis on 9/16/19.
//  Copyright © 2019 Alexa Francis. All rights reserved.
//

import UIKit

class TriggerCollectionViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addSubview(self.collectionView)
//        self.addConstraints()
    }

    func addConstraints() {
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            ])
    }
}
