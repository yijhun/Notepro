import SwiftUI
import SwiftData
import Models
import Observation

public struct MainContentView: View {
    @State private var selection: SidebarItem? = .notes
    @State private var selectedNote: Note?
    @State private var timerManager = LiveTimerManager()
    @Environment(\.modelContext) private var modelContext

    public init() {}

    public var body: some View {
        NavigationSplitView {
            List(selection: $selection) {
                NavigationLink(value: SidebarItem.notes) {
                    Label("Notes", systemImage: "note.text")
                }
                NavigationLink(value: SidebarItem.calendar) {
                    Label("Calendar", systemImage: "calendar")
                }
            }
            .navigationTitle("Productivity")
        } content: {
            if let selection = selection {
                switch selection {
                case .notes:
                    NoteListView(selectedNote: $selectedNote)
                case .calendar:
                    TaskListView()
                }
            } else {
                Text("Select an item")
            }
        } detail: {
            if let selection = selection {
                switch selection {
                case .notes:
                    if let note = selectedNote {
                        NoteEditorView(note: note)
                    } else {
                        Text("Select a note")
                    }
                case .calendar:
                    CalendarView()
                }
            } else {
                Text("Select an item")
            }
        }
        .environment(timerManager)
        .onAppear {
            timerManager.setModelContext(modelContext)
        }
        .toolbar {
            if timerManager.isRunning {
                ToolbarItem(placement: .automatic) {
                    HStack {
                        Image(systemName: "timer")
                            .foregroundStyle(.red)
                        Text(timerManager.formattedTime)
                            .monospacedDigit()
                        Button {
                            timerManager.stop()
                        } label: {
                            Image(systemName: "stop.circle.fill")
                                .foregroundStyle(.red)
                        }
                    }
                    .padding(8)
                    .background(.ultraThinMaterial, in: Capsule())
                }
            }
        }
    }

    enum SidebarItem: Hashable {
        case notes
        case calendar
    }
}

// Simple Note List View for placeholder
struct NoteListView: View {
    @Query(sort: \Note.modifiedAt, order: .reverse) private var notes: [Note]
    @Binding var selectedNote: Note?
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        List(selection: $selectedNote) {
            ForEach(notes) { note in
                NavigationLink(value: note) {
                    VStack(alignment: .leading) {
                        Text(note.title)
                            .font(.headline)
                        Text(note.createdAt, style: .date)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .onDelete(perform: deleteNotes)
        }
        .navigationTitle("Notes")
        .toolbar {
            Button(action: addNote) {
                Label("Add Note", systemImage: "plus")
            }
        }
    }

    private func addNote() {
        let newNote = Note(title: "New Note")
        modelContext.insert(newNote)
        selectedNote = newNote
    }

    private func deleteNotes(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(notes[index])
        }
    }
}
