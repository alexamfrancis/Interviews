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
    
//    private func updateIcon() {
//        let profileIconView = Session.shared.profileIcon
//        let profileTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.profileIconTapped))
//        profileIconView.isUserInteractionEnabled = true
//        profileIconView.addGestureRecognizer(profileTapGestureRecognizer)
//        profileIconView.accessibilityIdentifier = accessibilityIDs.profileIcon.rawValue
//        self.headerViewController.setProfileIconView(profileIconView)
//    }
    
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            print("UICollectionViewFlowLayout failed to initialize properly")
            return .zero
        }
        
        let minimumInteritemSpacing = flowLayout.minimumInteritemSpacing
        let sectionInsetWidth = flowLayout.sectionInset.left + flowLayout.sectionInset.right
        let layoutMarginsWidth = self.appletCell.contentView.layoutMargins.left + self.appletCell.contentView.layoutMargins.right
        let safeAreaInsetsWidth = self.appletCell.contentView.safeAreaInsets.left + self.appletCell.contentView.safeAreaInsets.right
        let width: CGFloat
        if self.traitCollection.horizontalSizeClass == .compact {
            width = self.collectionView.bounds.width  - (sectionInsetWidth + layoutMarginsWidth + safeAreaInsetsWidth + minimumInteritemSpacing)
        } else {
            width = self.collectionView.bounds.width * 0.5  - (sectionInsetWidth + layoutMarginsWidth + safeAreaInsetsWidth + minimumInteritemSpacing)
        }
        
        self.appletCell.prepareForReuse()
        self.appletCell.contentView.bounds.size.width = width
        
        self.appletCell.configure(applet: self.cellDataSource[indexPath.row])
        
        self.appletCell.contentView.setNeedsLayout()
        self.appletCell.contentView.layoutIfNeeded()
        let layoutSize = self.appletCell.systemLayoutSizeFitting(CGSize(width: width, height: UIView.layoutFittingCompressedSize.height))
        return CGSize(width: width, height: layoutSize.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let applet = self.cellDataSource[indexPath.row]
        let viewController = AppletDetailViewController(applet)
        self.present(viewController, animated: true, completion: nil)
//        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
//
//extension ViewController: ChannelListSubscriptionDelegate {
//
//    func didTapChannel(appletCell: AppletCollectionViewCell) {
//        let viewController = AppletDetailViewController(appletCell.applet)
//        viewController.title = "LARGE TITLE"
//        self.present(viewController, animated: true, completion: {
//            print("THE APPLET VIEW WAS PRESENTED")
//        })
//    }
//}
