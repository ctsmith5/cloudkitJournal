//
//  EntryController.swift
//  JournalCloud2
//
//  Created by Colin Smith on 4/8/19.
//  Copyright © 2019 Colin Smith. All rights reserved.
//

import Foundation
import CloudKit

class EntryController {
    
    static let shared = EntryController()
    
    private init() {}
    
    var entries: [Entry] = []
    
    func save(title: String, bodyText: String, completion: @escaping ((Entry)?) -> Void ){
        let entry = Entry(title: title, bodyText: bodyText)
        let record = CKRecord(entry: entry)
        CKContainer.default().publicCloudDatabase.save(record) { (ckRecord, error) in
            if let error = error {
                print("errorStuff \(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let ckRecord = ckRecord,
            let entry = Entry(ckRecord: ckRecord) else {completion(nil) ; return}
            self.entries.append(entry)
            completion(entry)
        }
    }
    func fetchEntries(completion: @escaping ([Entry]?) -> Void){
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: EntryConstants.RecordType, predicate: predicate)
        CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("error stuff \(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let records = records else { completion(nil) ; return }
            let entries = records.compactMap{ Entry(ckRecord: $0) }
            self.entries = entries
            completion(entries)
        }
    }
}

