//
//  SnapshotTestCase.swift
//  PeriodTTests
//

import XCTest
import SwiftUI
import SnapshotTesting
@testable import PeriodT

/// Base class for SwiftUI snapshot tests.
///
/// Reference images live in `__Snapshots__/` next to each test file. They are
/// recorded on an iPhone 17 Pro simulator (3x) in light mode — run on the same
/// device so pixel comparisons are meaningful. To re-record after an intentional
/// UI change, set `isRecording = true` (or delete the PNG) and run once.
class SnapshotTestCase: XCTestCase {

    /// Flip to `true` (locally, never committed) to overwrite reference images.
    var isRecording: Bool { false }

    override func invokeTest() {
        withSnapshotTesting(record: isRecording ? .all : .missing) {
            super.invokeTest()
        }
    }

    /// Snapshots `view` at a fixed size, forcing light mode so the result
    /// doesn't depend on the simulator's appearance setting.
    func assertViewSnapshot<V: View>(
        of view: V,
        width: CGFloat,
        height: CGFloat,
        named name: String? = nil,
        file: StaticString = #filePath,
        testName: String = #function,
        line: UInt = #line
    ) {
        let host = view
            .environment(\.colorScheme, .light)
            .environment(\.locale, Locale(identifier: "en_US_POSIX"))

        assertSnapshot(
            of: host,
            as: .image(
                perceptualPrecision: 0.98,
                layout: .fixed(width: width, height: height),
                traits: UITraitCollection(userInterfaceStyle: .light)
            ),
            named: name,
            file: file,
            testName: testName,
            line: line
        )
    }
}
