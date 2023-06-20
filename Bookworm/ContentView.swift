//
//  ContentView.swift
//  Bookworm
//
//  Created by Rishav Gupta on 19/06/23.
//

import SwiftUI

struct PushButton: View {
    let title: String
    @Binding var isOn: Bool // Not @State. Only one source of truth. Shared state. When pushButton changes it should not change the local state, it should change the external state. @Binding has shared state from somewhere else.
    
    var onColors = [Color.red, Color.yellow]
    var offColors = [Color(white: 0.6), Color(white: 0.4)]
    
    var body: some View {
        Button(title) {
            isOn.toggle()
        }
        .padding()
        .background(
            LinearGradient(colors: isOn ? onColors : offColors, startPoint: .top, endPoint: .bottom)
        )
        .foregroundColor(.white)
        .clipShape(Capsule())
        .shadow(radius: isOn ? 0 : 5)
    }
}

// Core Data
// Core data is object graph and persistance framework - define objects, give properties to those objects and then read/write from permanent storage.


struct ContentView: View {
    // @Binding - lets us share local data with another view
    @State private var rememberMe = false
    
    @AppStorage("notes") private var notes = ""
    
    @FetchRequest(sortDescriptors: []) var students: FetchedResults<Student>
    // this upto date over time.
    
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: []) var books: FetchedResults<Book>
    
    @State private var showingAddScreen = false
    
    var body: some View {
//        Toggle("Remember Me", isOn: $rememberMe)
        // this has to change our bool when the user interacts with it. But how does it remember what value should be changed to? It has not got its own local state inside its toggle. Its changing the external rememberMe bool.
        // Binding lets us store a mutable value in a view that actually points to some other value from elsewhere. In toggle, the switch changes own local binding to a bool. But behind the scenes that local binding is actually manipulating the state property inside our view.
        
//        VStack {
//            PushButton(title: "Remember me", isOn: $rememberMe)
//            // Once the PushButton is created, it has its own state. the @State inside it is local data.
//            Text(rememberMe ? "On": "Off")
//
//            TextEditor(text: $notes)
//                .padding()
//                .frame(height: 200)
//
//            List(students) { student in
//                Text(student.name ?? "Unknown")
//            }
//            // Adding and Saving students, we have to access the managedObjectConext
//            Button("Add") {
//                let firstNames = ["Ginny", "harry", "Hermoine", "Luna", "Ron"]
//                let lastName = ["Granger", "Lovewood", "Potter", "Weasly"]
//
//                let chosenFirstName = firstNames.randomElement()!
//                let chosenLastName = lastName.randomElement()!
//
//                let student = Student(context: moc)
//                student.id = UUID()
//                student.name = "\(chosenFirstName) \(chosenLastName)"
//
//                try? moc.save()
//            }
        
        NavigationView {
            List {
                ForEach(books) { book in
                    NavigationLink {
                        Text(book.title ?? "Unknown title")
                    } label: {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            
                            VStack(alignment: .leading) {
                                Text(book.title ?? "Unknown title")
                                    .font(.headline)
                                
                                Text(book.author ?? "Unknown author")
                                    .font(.headline)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Bookworm")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddScreen.toggle()
                    } label: {
                        Label("Add Book", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddBookView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
