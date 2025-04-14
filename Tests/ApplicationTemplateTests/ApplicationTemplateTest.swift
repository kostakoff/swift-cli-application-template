import XCTest
@testable import ApplicationTemplate

final class ApplicationTemplateTests: XCTestCase {

    private var productsDirectory: URL {
        return Bundle.allBundles
            .first(where: { $0.bundlePath.hasSuffix(".xctest") })!
            .bundleURL.deletingLastPathComponent()
    }

    func testEchoOption() throws {
        let binaryURL = productsDirectory.appendingPathComponent("swift-application")
        
        let process = Process()
        process.executableURL = binaryURL
        process.arguments = [
            "--option", "echo",
            "HelloTest"
        ]
        
        let pipe = Pipe()
        process.standardOutput = pipe
        process.standardError = pipe
        
        try process.run()
        process.waitUntilExit()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)
        
        XCTAssertEqual(output?.trimmingCharacters(in: .whitespacesAndNewlines), "HelloTest")
    }

}
