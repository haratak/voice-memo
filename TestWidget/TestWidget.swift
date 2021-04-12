//
//  TestWidget.swift
//  TestWidget
//
//  Created by Takuya Hara on 2021/04/04.
//

import WidgetKit
import SwiftUI
import CoreData

struct Provider: TimelineProvider {
    
    var moc = PersistenceController.shared.managedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.moc = context
    }

    func placeholder(in context: Context) -> SimpleEntry {
        var memo:[Memo]?
        let request = NSFetchRequest<Memo>(entityName: "Memo")
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        
        do{
            let result = try moc.fetch(request)
            memo = result
        }catch let error as NSError{
            print("Could not fetch.\(error.userInfo)")
        }
        
        return SimpleEntry(date: Date(),memo: memo!)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        var memo:[Memo]?
        let request = NSFetchRequest<Memo>(entityName: "Memo")
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        
        do{
            let result = try moc.fetch(request)
            memo = result
        }catch let error as NSError{
            print("Could not fetch.\(error.userInfo)")
        }
        
        let entry = SimpleEntry(date: Date(),memo:memo!)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var memo:[Memo]?
        let request = NSFetchRequest<Memo>(entityName: "Memo")
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        
        do{
            let result = try moc.fetch(request)
            memo = result
        }catch let error as NSError{
            print("Could not fetch.\(error.userInfo)")
        }
        
        let currentDate = Date()

        
        let entries = [
            SimpleEntry(date: currentDate, memo: memo!),
        ]
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let memo: [Memo]
}

struct TestWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack{
//                    Text(entry.memo.first?.condition ?? "test")
                    Text(entry.date, style: .time)
                }
}

@main
struct TestWidget: Widget {
    let kind: String = "TestWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider(context: PersistenceController.shared.managedObjectContext)) { entry in
            TestWidgetEntryView(entry: entry)
                .environment(\.managedObjectContext, PersistenceController.shared.managedObjectContext)//
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        }
    }
}
