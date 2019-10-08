//
//  ViewController.swift
//  IFTTT
//
//  Created by Alexa Francis on 9/20/19.
//  Copyright © 2019 Alexa Francis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var mockData = MockData()
    private var collectionViewLayout = UICollectionViewFlowLayout()
    private let appletCell: AppletCollectionViewCell = AppletCollectionViewCell()
    private var cellDataSource = [Applet]()
    private var collectionView: UICollectionView
    
    init() {
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.collectionViewLayout)
        super.init(nibName: nil, bundle: nil)
        self.cellDataSource.sort { (applet1, applet2) -> Bool in
            return applet1.status == .enabled
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setupCollectionView()
        self.addConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.mockData.getApplets(completion: { applets in
            guard let safeApplets = applets else {
                print("applets are nil")
                return
            }
            self.cellDataSource = safeApplets
            self.collectionView.reloadData()
        })
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
    }
    
    private func setupCollectionView() {
        self.collectionView.backgroundColor = .white
//        self.collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        self.collectionView.contentInsetAdjustmentBehavior = .always
        self.collectionViewLayout.sectionInset = UIEdgeInsets(top: Constants.standardMargin, left: Constants.standardMargin, bottom: Constants.standardMargin, right: Constants.standardMargin)
        self.collectionView.collectionViewLayout = self.collectionViewLayout
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.registerCell(AppletCollectionViewCell.self)
        self.collectionView.preservesSuperviewLayoutMargins = true
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.collectionView)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // get width of collectionView
        // determine number of columns
        // section inset * 2
        // content
        let columnCount = UIDevice.current.userInterfaceIdiom == .pad ? (UIDevice.current.orientation.isPortrait ? 2 : 3) : 1
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            print("bad log statement")
            return CGSize()
        }
        let insets = collectionView.contentInset.left + collectionView.contentInset.right + flowLayout.sectionInset.left + flowLayout.sectionInset.right
        let extraSpace = flowLayout.minimumInteritemSpacing * CGFloat(columnCount - 1)
        let diameter = (collectionView.frame.width - insets - extraSpace) / CGFloat(columnCount)
        return CGSize(width: diameter, height: diameter)
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let applet = self.cellDataSource[indexPath.row]
        let viewController = AppletDetailViewController(applet)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }
}
