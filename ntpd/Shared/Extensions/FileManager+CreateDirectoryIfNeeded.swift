import Foundation

extension FileManager {

    func createDirectoryIfNeeded(at url: URL) throws {

        guard !fileExists(atPath: url.absoluteString) else { return }
        try createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
    }
}
