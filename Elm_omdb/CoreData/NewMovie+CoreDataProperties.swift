//
//  NewMovie+CoreDataProperties.swift
//  Elm_omdb
//
//  Created by Khaled Shuwaish on 25/03/2019.
//  Copyright © 2019 Khaled Shuwaish. All rights reserved.
//
//

import Foundation
import CoreData


extension NewMovie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewMovie> {
        return NSFetchRequest<NewMovie>(entityName: "NewMovie")
    }

    @NSManaged public var title: String?
    @NSManaged public var poster: String?
    @NSManaged public var released_ate: String?
    @NSManaged public var gener: String?

}
