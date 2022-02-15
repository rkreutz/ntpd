import SwiftUI

@main
struct ntpdApp: App {

    @StateObject var storage = try! FileLocalStorageService()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                NoteView(note: $storage.note)
            }
        }
    }
}
