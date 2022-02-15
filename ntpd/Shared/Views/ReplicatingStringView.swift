import SwiftUI
import CFRDT

struct ReplicatingStringView: View {

    @Binding var replicatingString: ReplicatingString

    init(_ replicatingString: Binding<ReplicatingString>) {

        self._replicatingString = replicatingString
    }

    var body: some View {

        TextEditor(text: $replicatingString.text)
            .border(Color(white: 0.9))
    }
}

extension ReplicatingString {

    var text: String {

        get { "\(self)" }
        set {

            let diff = newValue.difference(from: "\(self)")
            for d in diff {

                switch d {

                case let .insert(offset, element, _):
                    insert(ReplicatingCharacter(element), at: offset)

                case let .remove(offset, _, _):
                    remove(at: offset)
                }
            }
        }
    }
}
