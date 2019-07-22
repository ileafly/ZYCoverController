//
//  ViewController.swift
//  ZYCoverController
//
//  Created by luzhiyongmail@sohu.com on 07/21/2019.
//  Copyright (c) 2019 luzhiyongmail@sohu.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func flipAction(_ sender: Any) {
        self.navigationController?.pushViewController(ReaderContainer(), animated: true)
    }
    
    @IBAction func flipWithoutAnimation(_ sender: Any) {
        let readerContainer = ReaderContainer()
        readerContainer.animated = false
        self.navigationController?.pushViewController(readerContainer, animated: true)
    }
}

