//
//  ContentView.swift
//  iExpense
//
//  Created by Dany Blais Benoit on 2024-12-31.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
    
    func getColor() -> Color {
        if amount <= 10.0 {
            return .green
        } else if amount > 10.0 && amount <= 100.0 {
            return .orange
        } else {
            return .red
        }
    }
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
}

struct TableView: View {
    let item: ExpenseItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text(item.type)
            }
            
            Spacer()
            
            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                .foregroundStyle(item.getColor())
        }
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()
        
    var body: some View {
        NavigationStack {
            List {
                Section("Personal") {
                    ForEach(expenses.items.filter { $0.type == "Personal" }) { item in
                        TableView(item: item)
                    }
                    .onDelete { offsets in
                        removeItem(at: offsets, for: "Personal")
                    }
                }
                Section("Business") {
                    ForEach(expenses.items.filter { $0.type == "Business" }) { item in
                        TableView(item: item)
                    }
                    .onDelete { offsets in
                        removeItem(at: offsets, for: "Business")
                    }
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                NavigationLink(destination: AddView(expenses: expenses)) {
                    Image(systemName: "plus")
                }
            }
        }
    }
    
    func removeItem(at offsets: IndexSet, for type: String) {
        let itemsToRemove = expenses.items.filter { $0.type == type }
        for offset in offsets {
            if let index = expenses.items.firstIndex(where: { $0.id == itemsToRemove[offset].id }) {
                expenses.items.remove(at: index)
            }
        }
    }
}

#Preview {
    ContentView()
}
