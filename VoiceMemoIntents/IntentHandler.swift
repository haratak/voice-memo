//
//  IntentHandler.swift
//  VoiceMemoIntents
//
//  Created by Takuya Hara on 2021/03/31.
//

import Intents
import SwiftUI
import Foundation
import CoreData
// As an example, this class is set up to handle Message intents.
// You will want to replace this or add other intents as appropriate.
// The intents you wish to handle must be declared in the extension's Info.plist.

// You can test your example integration by saying things to Siri like:
// "Send a message using <myApp>"
// "<myApp> John saying hello"
// "Search for messages in <myApp>"

struct Provider {
    
    var moc = PersistenceController.shared.managedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.moc = context
    }
    
    func addMemo(number:Int32,condition:String)->Void{
        let newItem = Memo(context: moc)
        newItem.number = number
        newItem.condition = condition
        newItem.date = Date()
        do{
            try moc.save()
        }catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

}
class IntentHandler: INExtension,CreateMemoIntentHandling{
    var moc = PersistenceController.shared.managedObjectContext
    
    override func handler(for intent: INIntent) -> Any {

        guard intent is CreateMemoIntent else {
            fatalError("Unknown intent type: \(intent)")
        }

        return self
    }

    func handle(intent: CreateMemoIntent,
       completion: @escaping (CreateMemoIntentResponse) -> Void) {
        guard let number = intent.number
           else {
                completion(CreateMemoIntentResponse(code: .failure,
                        userActivity: nil))
                return
        }
        guard let condition = intent.condition
           else {
                completion(CreateMemoIntentResponse(code: .failure,
                        userActivity: nil))
                return
        }
        
        Provider(context: moc).addMemo(number: Int32(truncating: number), condition: condition)
        completion((CreateMemoIntentResponse).success(number: number, condition: condition))
    }
    
    func resolveNumber(for intent: CreateMemoIntent, with completion: @escaping (CreateMemoNumberResolutionResult) -> Void) {
        if let number = intent.number {
            completion(CreateMemoNumberResolutionResult.success(with:  Int(truncating: number)))
        } else {
            completion(CreateMemoNumberResolutionResult.needsValue())
            return
        }
    }
    
    func resolveCondition(for intent: CreateMemoIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        if let condition = intent.condition {
            completion(INStringResolutionResult.success(with:  condition))
        } else {
            completion(INStringResolutionResult.needsValue())
            return
        }
    }
        
}
