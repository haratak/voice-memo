//
//  ContentView.swift
//  VoiceMemo
//
//  Created by Takuya Hara on 2021/03/29.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    @ObservedObject var model = MemoStore()
    @State private var isPresented = false
    
    var body: some View {
        NavigationView{
            Form{
                List{
                    ForEach(model.memoList,id: \.id){ memo in
                            HStack {
                                Text(String(memo.number))
                                Text(memo.body)
                                    .onLongPressGesture {
                                    }
                                Spacer()
                                Text(memo.dateString)
                            }

                        }
                    .onDelete{
                            indexSet in if let index = indexSet.first {
                                let realm = try?Realm()
                                try? realm?.write {
                                    realm?.delete(self.model.memoList[index])
                                }
                            }
                        }
                }
            }
            .navigationTitle("リスト")
            .toolbar{
                      ToolbarItem(placement: .navigationBarTrailing){
                          Button(action: {
                            model.openNewPage.toggle()
                          }){
                            Image(systemName: "plus")
                                .font(.title2)
                          }
                      }
                 }
                  .sheet(isPresented: $model.openNewPage, content: {
                    AddMemoView()
                          .environmentObject(model)
                  })

        }
        
    }
}
