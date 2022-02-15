import Foundation
import CFRDT

struct Note: Identifiable, Replicable, Codable {

    var id: UUID = .init()
    var title: ReplicatingRegister<String> = ""
    var content: ReplicatingString = ""
    var createdAt: ReplicatingConstant<Date> = .init(.init())
    var updatedAt: ReplicatingRegister<Date> = .init(.init())

    func merged(with other: Note) -> Note {

        assert(id == other.id)
        var note = self
        note.title = note.title.merged(with: other.title)
        note.content = note.content.merged(with: other.content)
        note.createdAt = note.createdAt.merged(with: other.createdAt)
        note.updatedAt = note.updatedAt.merged(with: other.updatedAt)
        return self
    }
}

extension Note: Equatable {

    static func == (lhs: Note, rhs: Note) -> Bool {

        lhs.id                  ==  rhs.id                  &&
        lhs.title.value         ==  rhs.title.value         &&
        lhs.content.description ==  rhs.content.description &&
        lhs.createdAt.value     ==  rhs.createdAt.value     &&
        lhs.updatedAt.value     ==  rhs.updatedAt.value
    }
}

extension Note: CustomStringConvertible {

    var description: String {

        """
        Note: {
            id: \(id),
            title: \(title.value),
            content: \(content),
            createdAt: \(createdAt.value),
            updatedAt: \(updatedAt.value)
        }
        """
    }
}
