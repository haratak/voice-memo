//
//  ContentView.swift
//  VoiceMemo
//
//  Created by Takuya Hara on 2021/03/29.
//

import SwiftUI
import RealmSwift
import Intents

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
        .onAppear(){
//            self.makeDonation()
        }
        
    }
    func makeDonation(number:NSNumber) {
            let intent = CreateMemoIntent()
            print("Intent:\(intent)")
            
            intent.number = number
            intent.suggestedInvocationPhrase = "Create Memo"
            
            let interaction = INInteraction(intent: intent, response: nil)
            print("Interaction:\(interaction)")
            
            interaction.donate { (error) in
                if error != nil {
                    if let error = error as NSError? {
                        print(
                         "Donation failed: %@" + error.localizedDescription)
                    }
                } else {
                    print("Successfully donated interaction")
                }
        }
    }
}
