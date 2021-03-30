//
//  MemoDB.swift
//  VoiceMemo
//
//  Created by Takuya Hara on 2021/03/29.
//

import Foundation
import RealmSwift

class MemoDB: Object,Identifiable {
    @objc dynamic var id = 0
    @objc dynamic var number = 0
    @objc dynamic var body = ""
    @objc dynamic var date = Date()
    var dateString : String {
        get{
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .short
            dateFormatter.locale = Locale(identifier: "ja_JP")
            let dateString = dateFormatter.string(from: self.date)
            return dateString
        }
    }
    
    override static func primaryKey() -> String? {
      return "id"
    }
}

class MemosDB: Object {
    @objc dynamic var id: Int = 0
    let memos = List<MemoDB>()
    override static func primaryKey() -> String? {
      return "id"
    }
}
