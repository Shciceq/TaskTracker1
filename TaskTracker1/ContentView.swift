import SwiftUI

struct ContentView: View {
    @State private var showTasks = false
    @AppStorage("isDarkMode") private var isDarkMode = false  // хранение темы

    var body: some View {
        ZStack {
            (isDarkMode ? Color.black : Color.white)
                .ignoresSafeArea()

            if showTasks {
                TaskTrackerView(showTasks: $showTasks, isDarkMode: $isDarkMode)
            } else {
                VStack(spacing: 20) {
                    Image("TaskTracker")
                        .resizable()
                        .frame(width: 100, height: 100)
                    Text("TaskTracker")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(isDarkMode ? .white : .black)
                    Button("Start") {
                        showTasks = true
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light) // меняем цветовую схему
    }
}

struct TaskTrackerView: View {
    @Binding var showTasks: Bool
    @Binding var isDarkMode: Bool

    @State private var taskText = ""
    @State private var tasks: [String] = []
    @State private var showSettings = false

    var body: some View {
        VStack {
            HStack {
                Button("← Back") {
                    showTasks = false
                }
                .padding()
                .foregroundColor(isDarkMode ? .white : .blue)

                Spacer()

                Button {
                    showSettings = true
                } label: {
                    Image(systemName: "gearshape.fill")
                        .font(.title2)
                        .foregroundColor(isDarkMode ? .white : .blue)
                }
                .padding()
                .sheet(isPresented: $showSettings) {
                    SettingsView(isDarkMode: $isDarkMode)
                }
            }

            HStack {
                TextField("new task", text: $taskText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Add") {
                    if !taskText.isEmpty {
                        tasks.append(taskText)
                        taskText = ""
                    }
                }
                .padding(.leading)
            }
            .padding()

            List {
                ForEach(tasks, id: \.self) { task in
                    Text(task)
                        .foregroundColor(isDarkMode ? .white : .black)
                }
                .onDelete { indexSet in
                    tasks.remove(atOffsets: indexSet)
                }
            }
            .listStyle(PlainListStyle())
        }
        .background(isDarkMode ? Color.black : Color.white)
        .ignoresSafeArea(edges: .bottom)
    }
}

struct SettingsView: View {
    @Binding var isDarkMode: Bool
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("About App")) {
                    Text("TaskTracker v1.0")
                    Text("Created by Bohdan Harbuziuk")
                    Text("This app helps you manage your tasks easily.")
                }

                Section(header: Text("Appearance")) {
                    Toggle(isOn: $isDarkMode) {
                        Text("Dark Mode")
                    }
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
