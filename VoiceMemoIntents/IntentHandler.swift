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
    
    func addMemo(number:Int32,leftOvary:String,rightOvary:String,uterusCondition:String,treatment:String)->Void{
        let newItem = Memo(context: moc)
        newItem.number = number
        newItem.leftOvary = leftOvary
        newItem.rightOvary = rightOvary
        newItem.uterusCondition = uterusCondition
        newItem.treatment = treatment
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
        guard let rightOvary = intent.rightOvary
           else {
                completion(CreateMemoIntentResponse(code: .failure,
                        userActivity: nil))
                return
        }
        guard let leftOvary = intent.leftOvary
           else {
                completion(CreateMemoIntentResponse(code: .failure,
                        userActivity: nil))
                return
        }

        guard let treatment = intent.treatment
           else {
                completion(CreateMemoIntentResponse(code: .failure,
                        userActivity: nil))
                return
        }

        guard let uterusCondition = intent.uterusCondition
           else {
                completion(CreateMemoIntentResponse(code: .failure,
                        userActivity: nil))
                return
        }


        
        Provider(context: moc).addMemo(number: Int32(truncating: number),leftOvary:leftOvary,rightOvary:rightOvary,uterusCondition:uterusCondition,treatment:treatment)
        completion((CreateMemoIntentResponse).success(number: number, leftOvary:leftOvary,rightOvary:rightOvary,uterusCondition:uterusCondition,treatment:treatment))
    }
    
    func resolveNumber(for intent: CreateMemoIntent, with completion: @escaping (CreateMemoNumberResolutionResult) -> Void) {
        if let number = intent.number {
            completion(CreateMemoNumberResolutionResult.success(with:  Int(truncating: number)))
        } else {
            completion(CreateMemoNumberResolutionResult.needsValue())
            return
        }
    }
    
    
    func resolveRightOvary(for intent: CreateMemoIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        if let rightOvary = intent.rightOvary{
            completion(INStringResolutionResult.success(with: rightOvary))
        }else{
            completion(INStringResolutionResult.needsValue())
            return
        }
    }
    
    func resolveLeftOvary(for intent: CreateMemoIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        if let leftOvary = intent.leftOvary{
            completion(INStringResolutionResult.success(with: leftOvary))
        }else{
            completion(INStringResolutionResult.needsValue())
            return
        }
    }
    
    func resolveTreatment(for intent: CreateMemoIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        if let treatment = intent.treatment{
                    completion(INStringResolutionResult.success(with: treatment))
                }else{
                    completion(INStringResolutionResult.needsValue())
                    return
                }
    }
    
    func resolveUterusCondition(for intent: CreateMemoIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        if let uterusCondition = intent.uterusCondition{
                    completion(INStringResolutionResult.success(with: uterusCondition))
                }else{
                    completion(INStringResolutionResult.needsValue())
                    return
                }
    }
    
        
}
