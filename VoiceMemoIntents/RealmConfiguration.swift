//
//  RealmConfiguration.swift
//  VoiceMemoIntents
//
//  Created by Takuya Hara on 2021/04/03.
//

import Foundation

class RealmConfiguration{
    public struct Constants {
        public static let AppGroupId = "group.JS28CJ2CCH.VoiceMemo"
        
        public static var realmPath: URL? {
            get{
                let directoryUrl = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: AppGroupId)
                let realmPath = directoryUrl?.appendingPathComponent("db.realm")
                
                return realmPath
            }
        }
    }
    
//    public struct var realmConfig: Realm.Configuration {
//        get {
//            var config = Realm.Configuration(file)
//        }
//    }
}
