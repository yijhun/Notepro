import SwiftUI
import SwiftData
import Models

public struct TaskListView: View {
    // Predicate to find tasks with no time blocks (unscheduled)
    // SwiftData predicates can be tricky with optionals. We'll use a safer check if possible.
    // However, for this environment, let's assume standard behavior.
    // A task is unscheduled if timeBlocks is nil or empty.
    @Query(filter: #Predicate<Task> { $0.timeBlocks?.isEmpty != false }, sort: \Task.createdAt)
    private var tasks: [Task]

    @Environment(\.modelContext) private var modelContext
    @Environment(LiveTimerManager.self) private var timerManager
    @State private var showingAddTask = false
    @State private var newTaskTitle = ""

    public init() {}

    public var body: some View {
        List {
            Section(header: Text("Unscheduled Tasks")) {
                ForEach(tasks) { task in
                    HStack {
                        Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                            .onTapGesture {
                                task.isCompleted.toggle()
                            }
                        Text(task.title)
                        Spacer()
                        Button(action: {
                            timerManager.start(task: task)
                        }) {
                            Image(systemName: "play.circle")
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                    .draggable(TaskDraggable(id: task.id, title: task.title))
                }
                .onDelete(perform: deleteTasks)
            }
        }
        .navigationTitle("Tasks")
        .toolbar {
            Button(action: { showingAddTask = true }) {
                Image(systemName: "plus")
            }
        }
        .sheet(isPresented: $showingAddTask) {
            NavigationStack {
                Form {
                    TextField("Task Title", text: $newTaskTitle)
                }
                .navigationTitle("New Task")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") { showingAddTask = false }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") {
                            addTask()
                            showingAddTask = false
                        }
                        .disabled(newTaskTitle.isEmpty)
                    }
                }
            }
        }
    }

    private func addTask() {
        let task = Task(title: newTaskTitle)
        modelContext.insert(task)
        newTaskTitle = ""
    }

    private func deleteTasks(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(tasks[index])
        }
    }
}
