//
//  CreateMemoView.swift
//  VoiceMemo
//
//  Created by Takuya Hara on 2021/03/31.
//

import SwiftUI
import Intents

struct CreateMemoView: View {
    var body: some View {
        
        Text("test")
    }
    func makeDonation( number:NSNumber) {
            let intent = CreateMemoIntent()
            
            intent.number = number
            intent.suggestedInvocationPhrase = "Create Memo \(number)"
            
            let interaction = INInteraction(intent: intent, response: nil)
            
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
    
