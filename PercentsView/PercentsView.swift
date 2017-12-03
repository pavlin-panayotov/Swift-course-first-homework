//
//  PercentsView.swift
//  PercentsView
//
//  Created by Pavlin Panayotov on 3.12.17.
//  Copyright © 2017 Pavlin Panayotov. All rights reserved.
//

import UIKit

final class PercentsView: UIView {
    
    func setPercents(_ percents: [Int], colors: [UIColor]) {
        layer.sublayers = nil
        
        addLayers(percents: percents, colors: colors)
    }
}
