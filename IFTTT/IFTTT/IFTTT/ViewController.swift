//
//  ViewController.swift
//  IFTTT
//
//  Created by Alexa Francis on 9/20/19.
//  Copyright © 2019 Alexa Francis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private struct Constants {
        /// Margin from right anchor of safe area to right anchor of Image
        static let collectionViewVerticalInset: CGFloat = 2.0
        static let estimatedItemHeight: CGFloat = 150.0
        static let standardSpacing: CGFloat = 16.0
    }

    private var collectionViewLayout = UICollectionViewFlowLayout()
    private let appletCell: AppletCollectionViewCell = AppletCollectionViewCell()
    private var cellDataSource = MockData.applets
    private var collectionView: UICollectionView
    
    init() {
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.collectionViewLayout)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setupCollectionView()
        self.addHorizontalConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
    }
    
    private func addHorizontalConstraints() {
        NSLayoutConstraint.activate([
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
    }
    
    private func setupCollectionView() {
        self.view.backgroundColor = .white
        self.collectionView.backgroundColor = .white
        self.collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        self.collectionViewLayout.minimumInteritemSpacing = Constants.standardSpacing
        self.collectionViewLayout.minimumLineSpacing = Constants.standardSpacing
        self.collectionViewLayout.sectionInset = UIEdgeInsets(top: Constants.collectionViewVerticalInset, left: Constants.standardSpacing, bottom: Constants.collectionViewVerticalInset, right: Constants.standardSpacing)
        self.collectionView.collectionViewLayout = self.collectionViewLayout
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.registerCell(AppletCollectionViewCell.self)
        self.collectionView.preservesSuperviewLayoutMargins = true
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.collectionView)
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cellDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueCell(AppletCollectionViewCell.self, for: indexPath)
        cell.configure(applet: self.cellDataSource[indexPath.row])
        cell.reloadInputViews()
        return cell
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let applet = self.cellDataSource[indexPath.row]
        let viewController = AppletDetailViewController(applet)
        self.navigationController?.present(viewController, animated: true, completion: nil)
    }
}
