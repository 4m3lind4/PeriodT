//
//  TrackingComponentSnapshotTests.swift
//  PeriodTTests
//

import XCTest
import SwiftUI
import SnapshotTesting
@testable import PeriodT

/// Snapshots for the leaf components on the Calendar / Tracking tab.
final class TrackingComponentSnapshotTests: SnapshotTestCase {

    func testFutureDayErrorView() {
        // Fixed date so the weekday/day label never changes between runs.
        assertViewSnapshot(
            of: FutureDayErrorView(day: TestHelpers.date(2026, 9, 21)) {}.padding(),
            width: 360, height: 180
        )
    }

    // MARK: Shared error card

    func testErrorCardSaveFailed() {
        assertViewSnapshot(
            of: ErrorCardView(error: .saveFailed(.workout)) {}.padding(),
            width: 360, height: 200
        )
    }

    func testErrorCardDataUnavailable() {
        assertViewSnapshot(
            of: ErrorCardView(error: .dataUnavailable) {}.padding(),
            width: 360, height: 240
        )
    }
}
