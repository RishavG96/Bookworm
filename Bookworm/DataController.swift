//
//  DataController.swift
//  Bookworm
//
//  Created by Rishav Gupta on 19/06/23.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    //NSPersistentContainer - core data type responsible for loading a model and giving us access to data inside
    
    //NS - Next Step (Steve Jobs company)
    let container = NSPersistentContainer(name: "Bookworm")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
