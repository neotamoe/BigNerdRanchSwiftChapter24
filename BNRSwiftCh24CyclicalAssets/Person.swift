//
//  Person.swift
//  BNRSwiftCh24CyclicalAssets
//
//  Created by Neota Moe on 7/5/17.
//  Copyright © 2017 Neota Moe. All rights reserved.
//

import Foundation

//swift is built on automatic reference counting so the compiler is responsible for analyzing code and inserting retain and release calls to manage reference count of class instances...but still important to understand how it works as there are common mistakes that can cause memory management problems

class Person: CustomStringConvertible {
    let name: String
    let accountant = Accountant()
    var assets = [Asset]()
    
    var description: String {
        return "Person(\(name))"
    }
    
    init(name: String) {
        self.name = name
        
        accountant.netWorthChangedHandler = {
            [weak self]netWorth in
            
            self?.netWorthDidChange(to: netWorth)
        }
    }
    
    deinit {
        print("\(self) is being deallocated")
    }
    
    func takeOwnership(of asset: Asset) {
//        asset.owner = self
//        assets.append(asset)
        accountant.gained(asset) {
            asset.owner = self
            assets.append(asset)
        }
    }
    
    func netWorthDidChange(to netWorth: Double) {
        print("The net worth of \(self) is now \(netWorth)")
    }
    
    // @escaping attribute tells the compiler that handler can escape the useNetWorthChangedHandler(_:) method
    func useNetWorthChangedHandler(handler: @escaping(Double) -> Void) {
        accountant.netWorthChangedHandler = handler
    }
}


