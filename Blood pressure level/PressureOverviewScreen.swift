//
//  PressureOverviewScreen.swift
//  Blood pressure level
//
//  Created by mix on 23.10.2024.
//

import SwiftUI


struct PressureOverviewScreen: View {

	@State var period: PresentationPeriod = .day
	
	var body: some View {
		VStack {
			VStack(alignment: .center, spacing: 16) {
				HStack(alignment: .center, content: {
					Image("logo")
						.renderingMode(.template)
						.foregroundStyle(.primary)
					Text("Мой доктор")
						.font(.system(size: 16))
				})
				ZStack(alignment: .center, content: {
					VStack(spacing: 2, content: {
						Text("Давление")
							.font(.system(size: 18))
							.bold()
						let formattedDate = Date.now.formatted(.dateTime.month().year())
						Text(formattedDate + " " + "г.")
							.font(.system(size: 14))
					})
					Button(action: {
						
					}, label: {
						ZStack(content: {
							RoundedRectangle(cornerRadius: 10)
								.fill(.red)
								.frame(width: 32, height: 32)
							Image(systemName: "plus")
								.tint(.primary)
								.font(.system(size: 24))
								.fontWeight(.light)
						})						
					})
					.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .trailing)
				})
			
			}
			Picker("", selection: $period) { 
				ForEach(PresentationPeriod.allCases, id: \.self) { period in
					Text(String(describing: period).capitalized)
				}
				.background(.red)
				.padding()

			}
			.pickerStyle(.segmented)
			Spacer()
			
		}
		.padding()
	}
}


#Preview {
    PressureOverviewScreen()
}

enum PresentationPeriod: String, CaseIterable {
	case day = "День"
	case week = "Неделя"
	case month = "Месяц"
}


//import CoreData


//    @Environment(\.managedObjectContext) private var viewContext
//
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>

			//            List {
			//                ForEach(items) { item in
			//                    NavigationLink {
			//                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
			//                    } label: {
			//                        Text(item.timestamp!, formatter: itemFormatter)
			//                    }
			//                }
			//                .onDelete(perform: deleteItems)
			//            }
			//            .toolbar {
			//                ToolbarItem(placement: .navigationBarTrailing) {
			//                    EditButton()
			//                }
			//                ToolbarItem {
			//                    Button(action: addItem) {
			//                        Label("Add Item", systemImage: "plus")
			//                    }
			//                }
//		}
		//            Text("Select an item")
//	}
//}
//
//    private func addItem() {
//        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//}
//
//private let itemFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .short
//    formatter.timeStyle = .medium
//    return formatter
//}()

//		.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
