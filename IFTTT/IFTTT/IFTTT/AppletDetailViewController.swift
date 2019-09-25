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
        self.view.backgroundColor = .green
        
        self.navigationController?.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.dismissView))
    }
    
    @objc private func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
}
