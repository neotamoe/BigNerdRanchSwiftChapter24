//
//  Accountant.swift
//  BNRSwiftCh24CyclicalAssets
//
//  Created by Neota Moe on 7/5/17.
//  Copyright © 2017 Neota Moe. All rights reserved.
//

import Foundation

class Accountant {
    typealias NetWorthChanged = (Double) -> Void
    
    var netWorthChangedHandler: NetWorthChanged? = nil
    var netWorth: Double = 0.0 {
        didSet {
            netWorthChangedHandler?(netWorth)
        }
    }
    
    func gained(_ asset: Asset, completion: () -> Void) {
        netWorth += asset.value
        completion()
    }
}

