//
//  ContentView.swift
//  To-Do List
//
//  Created by Ethan Davis on 1/25/24.
//

import SwiftUI

struct ContentView: View {
   @ObservedObject var toDoList = ToDoList()
    @State private var showingAddItemView = false
    var body: some View {
        NavigationView {
            List {
                ForEach(toDoList.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.priority)
                                .font(.headline)
                            Text(item.description)
                        }
                        Spacer()
                        Text(item.dueDate, style: .date)
                    }
                }
                .onMove { indices, newOffset in
                    toDoList.items.move(fromOffsets: indices, toOffset: newOffset)
                }
                .onDelete { indexSet in
                    toDoList.items.remove(atOffsets: indexSet)
                }
            }
            .navigationBarTitle("To Do List", displayMode: .inline)
            .sheet(isPresented: $showingAddItemView, content: {
                AddItemView(toDoList: toDoList)
            })
            .navigationBarItems(leading: EditButton(),
                                trailing: Button(action: {
                                   showingAddItemView = true}) {
                                   Image(systemName: "plus")
                })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ToDoItem: Identifiable, Codable {
    var id = UUID()
    var priority = String()
    var description = String()
    var dueDate = Date()
}
