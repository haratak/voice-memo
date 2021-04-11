//
//  ContentView.swift
//  Coredata+SwiftUI
//
//  Created by Takuya Hara on 2021/04/03.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var isPresented = false

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Memo.date, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Memo>

    var body: some View {
        NavigationView{
            List {
                ForEach(items) { item in
                    VStack(alignment: .leading)
                      {
                        HStack{
                            Text("\(item.number)")
                            Spacer()
                            Text("\(item.date!, formatter: itemFormatter)")
                        }.font(.title3)
                        VStack{
                            Text("左卵巣 : \(item.leftOvary ?? " - ")")
                            Text("右卵巣 : \(item.rightOvary ?? " - ")")
                            Text("子宮 : \(item.uterusCondition ?? " - ")")
                            Text("処置 : \(item.treatment ?? " - ")")
                        }.padding(1)
                    }
                    
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("ツッコーーム")
            .toolbar{
                      ToolbarItem(placement: .navigationBarTrailing){
                          Button(action: {
                            self.isPresented.toggle()
                          }){
                            Image(systemName: "plus")
                                .font(.title2)
                          }
                      }
                 }
            .sheet(isPresented: $isPresented, content: {
              AddMemoView()
                    
            })

        }
        
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .none
    return formatter
}()
