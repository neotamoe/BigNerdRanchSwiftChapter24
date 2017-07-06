//
//  main.swift
//  BNRSwiftCh24CyclicalAssets
//
//  Created by Neota Moe on 7/5/17.
//  Copyright © 2017 Neota Moe. All rights reserved.
//

import Foundation

var bob: Person? = Person(name: "Bob")
print("created \(bob)")
var laptop: Asset? = Asset(name: "Shiny Laptop", value: 1_500.0)
var hat: Asset? = Asset(name: "Cowboy Hat", value: 175.0)
var backpack: Asset? = Asset(name: "Blue Backpack", value: 45.0)

bob?.useNetWorthChangedHandler { netWorth in
    print("Bob's net worth is now \(netWorth)")
}

// this creates two strong reference cycles.  bob has a reference to the laptop and the laptop has a reference to bob (via it's owner property).  Same for bob and the hat.  the memory for these instances is no longer reachable--al variables pointing to them gone, but memory will never be reclaimed because each instance has a reference count greater than 0
// break this cycle by adding "weak" in front of var owner: Person
// weak reference doesn't increase the reference count of the instance it refers to
// weak references must always be declared as var, not let
// weak references must always be declared as optional
// since Person is a class that owns assets, it makes sense to keep strong references to tha ssets.  Asset is a class owned by the person, so if it wants a reference to the owner, tthat reference should be weak.
bob?.takeOwnership(of: laptop!)
bob?.takeOwnership(of: hat!)

print("While Bob is alive, hat's owner is \(hat!.owner)")

bob = nil
print("the bob variable is now \(bob)")

print("After Bob is deallocated, hat's owner is \(hat!.owner)")

laptop = nil
hat = nil
backpack = nil


