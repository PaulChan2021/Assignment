//
//  WishList+CoreDataProperties.swift
//  Assignment
//
//  Created by Banana on 13/1/2022.
//
//

import Foundation
import CoreData


extension WishList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WishList> {
        return NSFetchRequest<WishList>(entityName: "WishList")
    }

    @NSManaged public var items: String?

}

extension WishList : Identifiable {

}
