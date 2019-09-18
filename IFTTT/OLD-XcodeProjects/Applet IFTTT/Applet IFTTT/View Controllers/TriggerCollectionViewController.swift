//
//  TriggerCollectionViewController.swift
//  Applet IFTTT
//
//  Created by Alexa Francis on 9/16/19.
//  Copyright © 2019 Alexa Francis. All rights reserved.
//

import UIKit


class TriggerCollectionViewController: UICollectionViewController {
//    let requestManager = RequestManager()
    var myDataSource: [Applet] = {
        var dataArray = [Applet]()
        var channelDataSource = ["one", "two", "three", "four"]
        for string in channelDataSource {
            dataArray.append(Applet(id: string, created: string, serviceSlug: string, serviceOwner: string, name: string, description: string, brandColor: string, status: string, author: string, installCount: string, backgroundImages: string, userFeedback: string))
        }
        return dataArray
    }()
    
    private lazy var triggerCollectionViewLayout: UICollectionViewFlowLayout = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        collectionViewLayout.itemSize = CGSize(width: 50.0, height: 50.0)
        return collectionViewLayout
    }()

    
    init() {
        super.init(nibName: nil, bundle: nil)
//        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.triggerCollectionViewLayout)
//        self.collectionView.collectionViewLayout = self.triggerCollectionViewLayout
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.setupCollectionView()
//        self.collectionView.register(AppletCollectionViewCell.self, forCellWithReuseIdentifier: "")
        self.setupCollectionView()
    }
    
    func setupCollectionView() {
        self.view.backgroundColor = .white
//        self.collectionView.backgroundColor = .white
//        self.triggerCollectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//        self.triggerCollectionViewLayout.minimumInteritemSpacing = 20
//        self.triggerCollectionViewLayout.minimumLineSpacing = 40
//        self.triggerCollectionViewLayout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
//        self.triggerCollectionViewLayout.footerReferenceSize.height = 40
//        self.collectionView.collectionViewLayout = self.triggerCollectionViewLayout
//        self.collectionView.preservesSuperviewLayoutMargins = true
//        self.collectionView.translatesAutoresizingMaskIntoConstraints = false

//        NSLayoutConstraint.activate([
//            self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
//            self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
//            self.collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
//            self.collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
//            ])
    }
    
    //    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    //        let cell = UICollectionViewCell(frame: .zero)
    //        cell.translatesAutoresizingMaskIntoConstraints = false
    //        return cell
    //    }
//    private func setupCollectionView() {
//        self.view.backgroundColor = .white
//        self.collectionView.backgroundColor = .white
//        self.triggerCollectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//        self.triggerCollectionViewLayout.minimumInteritemSpacing = 20
//        self.triggerCollectionViewLayout.minimumLineSpacing = 40
//        self.triggerCollectionViewLayout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
//        self.triggerCollectionViewLayout.footerReferenceSize.height = 40
//        self.collectionView.collectionViewLayout = self.triggerCollectionViewLayout
//        self.collectionView.preservesSuperviewLayoutMargins = true
//        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addSubview(self.collectionView)
//    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension TriggerCollectionViewController: UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = AppletCollectionViewCell(id: "", name: "", author: "", description: "")
        let diameter = UIScreen.main.bounds.width / 4
        cell.clipsToBounds = true
        cell.layer.cornerRadius = diameter / 2
        cell.backgroundColor = .blue
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.myDataSource.count
    }
}
