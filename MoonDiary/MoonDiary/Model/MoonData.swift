//
//  MoonData.swift
//  MoonDiary
//
//  Created by hyebin on 2023/08/28.
//

import SwiftUI
import RealmSwift

class MoonData: Object {
    @Persisted var yearMonth: String
    @Persisted var date: Date
    @Persisted var phase: Double
}

class MoonDataManager{
    let realm = try! Realm()

    func addNewMoon(_ data: (date: Date, phase: Double)) {
        let newMoonData = MoonData()
        newMoonData.yearMonth = data.date.dateToYearMonth()
        newMoonData.date = data.date
        newMoonData.phase = data.phase
        
        do {
            try! realm.write {
                realm.add(newMoonData)
            }
        } catch {
            print("Error add new realm \(error)")
        }
        
    }
    
    //TODO: update
    
    func readMoonData(_ yearMonth: String) -> [Date: Double]{
        let predicate = NSPredicate(format: "yearMonth = %@", yearMonth)
        let sortDescriptors = [SortDescriptor(keyPath: "date", ascending: true)]
        
        let filteredResults = realm.objects(MoonData.self)
            .filter(predicate)
            .sorted(by: sortDescriptors)
        
        var moons = [Date: Double]()
        for result in filteredResults {
            moons[result.date] = result.phase
        }
        return moons
    }
    
    func readDisplayMoon(_ yearMonth: String) -> [(date: Date, phase: Double)] {
        let predicate = NSPredicate(format: "yearMonth = %@", yearMonth)
        let sortDescriptors = [SortDescriptor(keyPath: "date", ascending: true)]
        
        let filteredResults = realm.objects(MoonData.self)
            .filter(predicate)
            .sorted(by: sortDescriptors)
        
        var moons = [(date: Date, phase: Double)]()
        for result in filteredResults {
            moons.append((result.date, result.phase))
        }
        return moons
    }
    
    func deleteAll() {
        try! realm.write {
            realm.delete(realm.objects(MoonData.self))
          }
    }
}
