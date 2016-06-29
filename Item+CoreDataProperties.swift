//
//  Item+CoreDataProperties.swift
//  CoreData-TapList
//
//  Created by zklgame on 6/29/16.
//  Copyright © 2016 Zhejiang University. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import UIKit
import CoreData

extension Item {

    @NSManaged var name: String?
    @NSManaged var score: NSNumber?
    @NSManaged var image: UIImage?

}
