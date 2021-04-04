//
//  VoiceMemo.swift
//  VoiceMemo
//
//  Created by Takuya Hara on 2021/03/30.
//

import SwiftUI
import Intents

@main
struct VoiceMemo: App {
    @Environment(\.scenePhase) private var scenePhase
    let persistenceController = PersistenceController.shared.managedObjectContext

    
    var body: some Scene {
        
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController)
        }
        .onChange(of: scenePhase) { phase in
                 INPreferences.requestSiriAuthorization({status in
                 // Handle errors here
                    
             })
         }
    }
}
