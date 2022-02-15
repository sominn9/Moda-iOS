//
//  HealthKitManager.swift
//  Moda
//
//  Created by 신소민 on 2022/02/12.
//

import Foundation
import HealthKit

class HealthKitManager {
    
    static let shared = HealthKitManager()
    
    private let healthStore = HKHealthStore()
    
    private init() { }
    
    func requestAuthorization() {
        let types = Set([HKObjectType.quantityType(forIdentifier: .stepCount)!])
        
        healthStore.requestAuthorization(toShare: .none, read: types) { success, error in
            if success {
                
            }
        }
    }
    
    func readStepCount(start: Date, completion: @escaping (Int) -> Void) {
        
        if HKHealthStore.isHealthDataAvailable() {
 
            guard let stepType = HKSampleType.quantityType(forIdentifier: .stepCount) else { fatalError() }
            
            let predicate = HKQuery.predicateForSamples(withStart: start, end: Date(), options: .strictStartDate)
        
            let query = HKSampleQuery(sampleType: stepType,
                                      predicate: predicate,
                                      limit: 0,
                                      sortDescriptors: nil) { sampleQuery, sampleArray, error in
                if error == nil {
                    
                    var steps: Double = 0.0
                    
                    for sample: HKQuantitySample in (sampleArray as? [HKQuantitySample]) ?? [] {
                        steps += sample.quantity.doubleValue(for: .count())
                    }
                    
                    completion(Int(steps))
                }
            }
            
            healthStore.execute(query)
        }
    }
    
}
