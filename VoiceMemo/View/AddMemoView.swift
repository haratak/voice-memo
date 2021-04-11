//
//  MemoRegistrationView.swift
//  VoiceMemo
//
//  Created by Takuya Hara on 2021/03/30.
//

import SwiftUI

struct AddMemoView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var number:Int = 0
    @State private var leftOvary:String = ""
    @State private var rightOvary:String = ""
    @State private var uterusCondition:String = ""
    @State private var treatment:String = ""
    @State private var date:Date = Date()
    

    var body: some View {
    
        NavigationView{
            List{
                Section(header: Text("耳標番号")){
                    TextField("" ,text: self.$number.IntToStrDef(0))
                        .keyboardType(.decimalPad)
                }
                Section(header: Text("左の卵巣")){
                    TextField("" ,text: self.$leftOvary
                    )
        
                }
                Section(header: Text("右の卵巣")){
                    TextField("" ,text: self.$rightOvary
                    )
        
                }
                Section(header: Text("子宮の状態")){
                    TextField("" ,text: self.$uterusCondition
                    )
        
                }
                Section(header: Text("処置")){
                    TextField("" ,text: self.$treatment
                    )
                }
                Section(header: Text("記録日")){
                    DatePicker("",
                               selection: self.$date,displayedComponents:.date)
                        .labelsHidden()
                }
            }
            .navigationTitle("記録を追加する")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action: {
                            addItem()
                            self.presentationMode.wrappedValue.dismiss()
                        
                    },label: {
                        Text("完了")
                    })
                }
                ToolbarItem(placement: .navigationBarLeading){
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    },label :{
                        Text("キャンセル")
                    })
                }
            }
        }
        .listStyle(GroupedListStyle())
        }
    
    private func addItem() {
        withAnimation {
            let newItem = Memo(context: viewContext)
            newItem.date = self.date
            newItem.number = Int32(self.number)
            newItem.leftOvary = self.leftOvary
            newItem.rightOvary = self.rightOvary
            newItem.uterusCondition = self.uterusCondition
            newItem.treatment = self.treatment
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
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


