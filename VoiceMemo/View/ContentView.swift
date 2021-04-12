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

    @State private var showNewItemView = false
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Memo.date, ascending: true)],
        animation: .default)

    private var memos: FetchedResults<Memo>

    var body: some View {
        NavigationView{
            List {
                ForEach(memos) { memo in
//                    NavigationLink(
//                        destination: AddMemoView()){
                        VStack(alignment: .leading)
                          {
                            HStack{
                                Text("\(memo.number)")
                                Spacer()
                                Text("\(memo.date!, formatter: itemFormatter)")
                            }.font(.title3)
                            VStack(alignment: .leading){
                                Text("左卵巣 : \(memo.leftOvary ?? " - ")")
                                Text("右卵巣 : \(memo.rightOvary ?? " - ")")
                                Text("子宮 : \(memo.uterusCondition ?? " - ")")
                                Text("処置 : \(memo.treatment ?? " - ")")
                            }.padding(1)
//                        }
                        
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("ツッコーーム")
            .toolbar{
                Button(action: {
                    showNewItemView.toggle()
                }
                ){
                    NavigationLink(
                        destination: AddMemoView()){
                        Image(systemName: "plus")
                            .font(.title2)
                    }
                }
             }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { memos[$0] }.forEach(viewContext.delete)

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
