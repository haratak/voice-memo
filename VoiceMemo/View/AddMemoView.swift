//
//  MemoRegistrationView.swift
//  VoiceMemo
//
//  Created by Takuya Hara on 2021/03/30.
//

import SwiftUI

struct AddMemoView: View {
    @EnvironmentObject var store : MemoStore
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
    
        NavigationView{
            List{
                Section(header: Text("耳標番号")){
                    TextField("" ,text: $store.number.IntToStrDef(0))
                        .keyboardType(.decimalPad)
                }
                Section(header: Text("本文")){
                    TextField("" ,text: $store.body
                    )
        
                }
                Section(header: Text("日時")){
                    DatePicker("",
                               selection: $store.date,displayedComponents:.date)
                        .labelsHidden()
                }
            }
            .navigationTitle("追加")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action: {store.create(presentaion: presentationMode)},label: {
                        Text("完了")
                    })
                }
                ToolbarItem(placement: .navigationBarLeading){
                    Button(action: {presentationMode.wrappedValue.dismiss()},label :{
                        Text("キャンセル")
                    })
                        
                    
                }
            }
        }
        .listStyle(GroupedListStyle())
        }
    
}

extension Binding where Value == Int {
    func IntToStrDef(_ def: Int) -> Binding<String> {
        return Binding<String>(get: {
            return String(self.wrappedValue)
        }) { value in
            self.wrappedValue = Int(value) ?? def
        }
    }
}


