//
//  MoodEntryViewModel.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 14/9/2026.
//

import Foundation
import Combine
import HealthKit

final class MoodLogViewModel: ObservableObject {
    @Published var valence: Double = 0
    @Published var selectedLabels: Set<HKStateOfMind.Label> = []

    private let healthStore = HKHealthStore()

//    func requestAuthorization() async throws { ... }
//    func saveEntry() async throws { ... }
//    func fetchRecentEntries() async throws -> [HKStateOfMind] { ... }
}
