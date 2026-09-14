//
//  AppModelContainer.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 14/9/2026.
//

import Foundation
import SwiftData
import OSLog

/// Builds the app's SwiftData container. `.modelContainer(for:)` calls
/// `fatalError` if the store can't be opened (corrupt file, failed
/// migration); this instead falls back to an in-memory store and reports
/// the problem so the app can tell the user.
enum AppModelContainer {
    private static let logger = Logger(subsystem: "PeriodT", category: "AppModelContainer")

    static let schema = Schema([PollAnswers.self, CompletedProgram.self])

    struct Result {
        let container: ModelContainer
        /// Set when the on-disk store failed and `container` is in-memory only.
        let loadError: AppError?
    }

    /// Opens the store described by `configuration` (the default on-disk
    /// store when omitted). Falls back to memory-only on failure.
    static func make(
        configuration: ModelConfiguration = ModelConfiguration(schema: schema)
    ) -> Result {
        do {
            let container = try ModelContainer(for: schema, configurations: configuration)
            return Result(container: container, loadError: nil)
        } catch {
            logger.error("Failed to open data store, falling back to in-memory: \(error.localizedDescription)")
        }

        // Memory-only stores have nothing to fail on except a broken schema,
        // which would be a programming error — so crashing there is correct.
        do {
            let fallback = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: schema, configurations: fallback)
            return Result(container: container, loadError: .dataUnavailable)
        } catch {
            fatalError("Could not create even an in-memory ModelContainer: \(error)")
        }
    }
}
