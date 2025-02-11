import XCTest
import OSLog
import Foundation
import SkipBridgeKt
@testable import HelloSwiftModel

let logger: Logger = Logger(subsystem: "HelloSwiftModel", category: "Tests")

@available(macOS 13, *)
final class HelloSwiftModelTests: XCTestCase {
    override func setUp() {
        #if os(Android)
        // needed to load the compiled bridge from the traspiled tests
        loadPeerLibrary(packageName: "swift-android", moduleName: "HelloSwiftModel")
        #endif
    }

    func testHelloSwiftModel() throws {
        logger.log("running testHelloSwiftModel")
        XCTAssertEqual(1 + 2, 3, "basic test")
    }

    func testViewModel() async throws {
        let vm = ViewModel()
        vm.items.append(Item(title: "ABC"))
        XCTAssertFalse(vm.items.isEmpty)
        XCTAssertEqual("ABC", vm.items.last?.title)

        vm.clear()
        XCTAssertTrue(vm.items.isEmpty)
    }

}
