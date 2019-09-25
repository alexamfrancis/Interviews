//
//  AppletDetailViewController.swift
//  IFTTT
//
//  Created by Alexa Francis on 9/24/19.
//  Copyright © 2019 Alexa Francis. All rights reserved.
//

import UIKit

class AppletDetailViewController: UIViewController {
    var applet: Applet
    
    init(_ applet: Applet) {
        self.applet = applet
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.dismissView))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        self.view.addGestureRecognizer(swipeDown)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.dismissView))
    }
    
    @objc private func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
}
