//
//  AppModelContainerTests.swift
//  PeriodTTests
//

import Testing
import Foundation
import SwiftData
@testable import PeriodT

/// The store factory must never crash the app: a broken on-disk store
/// falls back to memory and reports `.dataUnavailable`.
@Suite("AppModelContainer")
@MainActor
struct AppModelContainerTests {

    @Test func healthyStoreReportsNoError() throws {
        let config = ModelConfiguration(schema: AppModelContainer.schema, isStoredInMemoryOnly: true)
        let result = AppModelContainer.make(configuration: config)
        #expect(result.loadError == nil)

        // The container is usable.
        let context = result.container.mainContext
        _ = PollAnswers.fetchOrCreate(for: .now, in: context)
        try context.save()
    }

    @Test func unopenableStoreFallsBackToMemoryAndReportsError() throws {
        // CoreData will happily create missing directories, so to make a
        // store genuinely unopenable put a regular *file* where the parent
        // directory would need to be.
        let blocker = FileManager.default.temporaryDirectory
            .appendingPathComponent("periodt-blocker-\(UUID().uuidString)")
        try Data().write(to: blocker)
        defer { try? FileManager.default.removeItem(at: blocker) }

        let bogus = blocker.appendingPathComponent("store.sqlite")
        let config = ModelConfiguration(schema: AppModelContainer.schema, url: bogus)

        let result = AppModelContainer.make(configuration: config)

        #expect(result.loadError == .dataUnavailable)

        // Fallback container still works so the session isn't dead.
        let context = result.container.mainContext
        let record = PollAnswers.fetchOrCreate(for: .now, in: context)
        record.journal = "in memory"
        try context.save()
        #expect(try context.fetch(FetchDescriptor<PollAnswers>()).count == 1)

        // And nothing was written to disk at the bogus location.
        #expect(!FileManager.default.fileExists(atPath: bogus.path))
    }
}
