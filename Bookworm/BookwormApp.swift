//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Rishav Gupta on 19/06/23.
//

import SwiftUI

@main
struct BookwormApp: App {
   // Most apps use one core data store at any given time. Rather than every view try and make their own store, instead we make it when our app launches and store it inside the Swift UI environment so everywhere else we can use it
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
            // managedObjectContext - live versions of your data. When you load data or change data, those only exist in memory - until you say you are done and write it specifically into the persistant store. The job of the viewContext is to let us work with data in memory, which is faster as compared to working with disk all the time. NSManagedObject is made automatically when the Entity is created. It loads from persistance store and writs to persistance store back for us. ManagedObjects live inside ManagedObjectsContext.
        }
    }
}
