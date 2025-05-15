//
//  ContentView.swift
//  TaskTracker1
//
//  Created by Bohdan Harbuziuk on 5/14/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showTasks = false

    var body: some View {
        if showTasks {
            TaskTrackerView(showTasks: $showTasks) // передаём binding
        } else {
            VStack(spacing: 20) {
                Image("TaskTracker")
                    .resizable()
                    .frame(width: 100, height: 100)
                Text("TaskTracker")
                    .font(.largeTitle)
                    .bold()
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
}

struct TaskTrackerView: View {
    @Binding var showTasks: Bool // получаем binding из ContentView

    @State private var taskText = ""
    @State private var tasks: [String] = []

    var body: some View {
        VStack {
            HStack {
                Button("← Back") {
                    showTasks = false
                }
                .padding()
                .foregroundColor(.blue)
                
                Spacer()
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
                }
                .onDelete { indexSet in
                    tasks.remove(atOffsets: indexSet)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
