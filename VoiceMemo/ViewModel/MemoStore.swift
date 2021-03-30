//
//  MemoStore.swift
//  VoiceMemo
//
//  Created by Takuya Hara on 2021/03/29.
//
import SwiftUI
import RealmSwift


class MemoStore : ObservableObject {
    private var token: NotificationToken?
    private var memoListResults = try? Realm().objects(MemoDB.self)
    @Published var memoList: [MemoDB] = []
    @Published var number :Int = 0
    @Published var body :String = ""
    @Published var date :Date = Date()
    @Published var openNewPage :Bool = false
    
    init() {
        token = memoListResults?.observe { [weak self] _ in
            self?.memoList = self?.memoListResults?.map { $0 } ?? []
        }
    }
    
    func create(presentaion: Binding<PresentationMode>){
        do{
            let realm = try Realm()
            let memoDB = MemoDB()
            memoDB.id = UUID().hashValue
            memoDB.number = number
            memoDB.body = body
            memoDB.date = date
            
            try realm.write{
                memoList.append(memoDB)
                realm.add(memoDB)
            }
            
        } catch let error {
            print(error.localizedDescription)
        }
        presentaion.wrappedValue.dismiss()
    }
    
    func update(memoID: Int){
        do{
            let realm = try Realm()
            try realm.write{
                realm.create(MemoDB.self,value: ["id":memoID,
                                                 "body":"Updated","date":Date()],
                                        update: .modified)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func delete(object: MemoDB){
        guard let dbRef = try? Realm() else {return }
        try? dbRef.write{
            dbRef.delete(object)
        }


    }

}
