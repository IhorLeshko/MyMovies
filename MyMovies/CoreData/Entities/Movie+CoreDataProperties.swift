//
//  Movie+CoreDataProperties.swift
//  MyMovies
//
//  Created by Ihor on 01.02.2024.
//
//

import Foundation
import CoreData
import UIKit


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var id: String
    @NSManaged public var title: String
    @NSManaged public var year: String
    @NSManaged public var genre: String
    @NSManaged public var image: Data?

}

extension Movie : Identifiable {
}
