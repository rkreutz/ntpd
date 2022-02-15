import SwiftUI

struct NoteView: View {

    @Binding var note: Note
    @ScaledMetric private var spacing: CGFloat = 8

    var body: some View {

        VStack(alignment: .leading, spacing: spacing) {

            TextField("Title", text: $note.title.value)
                .font(.title)
                .multilineTextAlignment(.leading)
                .foregroundColor(.primary)

            ReplicatingStringView($note.content)

            Text("Created on \(date: note.createdAt.value)" as String)
                .font(.footnote)
                .foregroundColor(.secondary)
        }
        .onChange(of: note.content) { _ in note.updatedAt.value = .init() }
        .onChange(of: note.title.value) { _ in note.updatedAt.value = .init() }
        .padding()
        .navigationTitle("Note")
        .navigationBarTitleDisplayMode(.inline)
    }
}
