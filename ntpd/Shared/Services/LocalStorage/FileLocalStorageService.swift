import Foundation
import SwiftUI
import Combine

final class FileLocalStorageService: LocalStorageService {

    @Published var note: Note

    private let fileManager: FileManager
    private let directoryURL: URL
    private let fileURL: URL

    private var bag: Set<AnyCancellable> = []

    init(
        fileManager: FileManager = .default,
        directory: FileManager.SearchPathDirectory = .applicationSupportDirectory,
        domainMask: FileManager.SearchPathDomainMask = .userDomainMask
    ) throws {

        self.fileManager = fileManager
        self.directoryURL = try fileManager.url(for: directory, in: domainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("ntpd")
        self.fileURL = directoryURL.appendingPathComponent("note.json")

        try fileManager.createDirectoryIfNeeded(at: directoryURL)
        if  fileManager.fileExists(atPath: fileURL.path),
            let contents = fileManager.contents(atPath: fileURL.path) {

            self.note = try JSONDecoder().decode(Note.self, from: contents)
        } else {

            self.note = Note()
        }

        $note.encode(encoder: JSONEncoder())
            .tryMap { try $0.write(to: self.fileURL, options: [.completeFileProtection]) }
            .assertNoFailure()
            .sink(receiveValue: {})
            .store(in: &bag)
    }
}
