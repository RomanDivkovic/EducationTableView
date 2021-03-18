//
//  WishList+CoreDataProperties.swift
//  Courses
//
//  Created by Roman Divkovic on 2021-03-17.
//
//

import Foundation
import CoreData


extension WishList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WishList> {
        return NSFetchRequest<WishList>(entityName: "WishList")
    }

    @NSManaged public var course: [String]?
    @NSManaged public var courseInfo: [String]?
    @NSManaged public var courseLenght: [String]?
    @NSManaged public var education: String?

}

extension WishList : Identifiable {

}
