import SwiftUI

struct EditEintragSheet: View {
    @Environment(\.dismiss) var dismiss

    @State var eintrag: PlanEintrag
    var onSave: (PlanEintrag) -> Void

    var body: some View {
        NavigationStack {
            Form {
                Section("Unterricht") {
                    Text("\(eintrag.fach) – \(eintrag.klasse)")
                }

                Section("Thema") {
                    TextField("Thema eingeben", text: $eintrag.thema)
                }

                Section("Notiz") {
                    TextField("Notiz", text: $eintrag.notiz, axis: .vertical)
                        .lineLimit(3...6)
                }

                Section("Status") {
                    Picker("Status", selection: $eintrag.status) {
                        ForEach(PlanStatus.allCases) { status in
                            Label(status.displayName, systemImage: status.symbolName)
                                .tag(status)
                        }
                    }
                }
            }
            .navigationTitle("Bearbeiten")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Speichern") {
                        onSave(eintrag)
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Abbrechen") {
                        dismiss()
                    }
                }
            }
        }
    }
}
