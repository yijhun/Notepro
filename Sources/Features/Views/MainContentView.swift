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
                NavigationLink(value: SidebarItem.graph) {
                    Label("Graph", systemImage: "network")
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
                case .graph:
                    Text("Select a note to view connections")
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
                            .toolbar {
                                ToolbarItem(placement: .primaryAction) {
                                    NavigationLink(destination: SmartAssistantView(note: note)) {
                                        Label("Smart Assistant", systemImage: "sparkles")
                                    }
                                }
                            }
                    } else {
                        Text("Select a note")
                    }
                case .calendar:
                    CalendarView()
                        .toolbar {
                            ToolbarItem(placement: .primaryAction) {
                                Button {
                                    // Trigger Google Sync
                                    // In real implementation, call GoogleCalendarService.shared.syncEvent()
                                    print("Syncing with Google Calendar...")
                                } label: {
                                    Label("Sync Google", systemImage: "arrow.triangle.2.circlepath")
                                }
                            }
                        }
                case .graph:
                    GraphView()
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
        case graph
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
