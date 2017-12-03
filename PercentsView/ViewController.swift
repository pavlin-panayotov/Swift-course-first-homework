//
//  ViewController.swift
//  PercentsView
//
//  Created by Pavlin Panayotov on 3.12.17.
//  Copyright © 2017 Pavlin Panayotov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var percentsView: PercentsView!
    
    private let percents = [20, 30, 10, 40]
    private let colors: [UIColor] = [.red, .green, .blue, .purple]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        percentsView.setPercents(percents, colors: colors)
        percentsView.backgroundColor = view.backgroundColor
    }
}
