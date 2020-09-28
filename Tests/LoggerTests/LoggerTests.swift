import XCTest
@testable import Logger

final class LoggerTests: XCTestCase {
    override func setUp() {
        // Reset
        Logger.currentLogLevel = nil
    }
    
    func testInitialize() {
        Logger.initialize()
        
        // Should be initialized
        XCTAssertTrue(Logger.isInitialized)
        
        // Should have a default log level.
        XCTAssertEqual(Logger.currentLogLevel, .Debug)
    }
    
    func testInitializeWithParam() {
        Logger.intitialize(level: .Info)
        
        // Should be initialized
        XCTAssertTrue(Logger.isInitialized)
        
        // Should have logLevel of info
        XCTAssertEqual(Logger.currentLogLevel, .Info)
    }

    static var allTests = [
        ("testInitialize", testInitialize),
        ("testInitializeWithParams", testInitializeWithParam),
    ]
}
