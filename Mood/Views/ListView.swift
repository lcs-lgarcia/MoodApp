import Blackbird
import SwiftUI

struct ListView: View {
    
    @Environment(\.blackbirdDatabase) var db: Blackbird.Database?
    
    @BlackbirdLiveModels({ db in try await TodoItem.read(from: db)
    }) var todoItems
    @State var newItemDescription: String = ""
    @State var newItemEmoji: String = ""
    
    
    
    var body: some View {
      
        
        
        NavigationView{
            VStack{
                HStack{
                    Text("    How do you feel?")
                    Spacer()
                }
                HStack{
                    HStack{
                        TextField("Emoji", text:$newItemEmoji )
                        
                        TextField("Enter your mood", text:$newItemDescription )
                        Spacer()
                    }
                    
                    Button(action: {
                        Task {
                            try await db!.transaction { core in
                                try core.query("INSERT INTO TodoItem (description, emoji) VALUES (?, ?)", newItemDescription, newItemEmoji)
                            }
                        }
                        
                    }, label:{
                        Text("ADD")
                            .font(.caption)
                    })
                    
                }
                .padding(20)
                List{
                    ForEach(todoItems.results){
                        currentItem in
                        Label(title: {
                            Text(currentItem.description)
                        }, icon: {
                            Text(currentItem.emoji)
                        } )
                        
                        .onTapGesture {
                            Task{
                                try await db!.transaction { core in try core.query("UPDATE TodoItem SET emoji = (?) WHERE id = (?)",  currentItem.id)
                                    
                                }
                            }
                        }
                        
                    }
                    .onDelete(perform: removeRows)
                    
                }
            }
            .navigationTitle("Mood Mapper")
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        
        Task{
            try await db!.transaction{ core in
                
                var idList = ""
                for offset in offsets {
                    idList += "\(todoItems.results[offset].id),"
                }
                print(idList)
                idList.removeLast()
                print(idList)
                
                try core.query("DELETE FROM TodoItem WHERE id IN (?)", idList)
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}

