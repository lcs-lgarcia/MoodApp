import Blackbird
import Foundation

struct TodoItem: BlackbirdModel{
    @BlackbirdColumn var id: Int
    @BlackbirdColumn var description: String
    @BlackbirdColumn var emoji: String
}



var existingTodoItems = [

TodoItem(id: 1, description: "HAPPY", emoji: ""),

TodoItem(id: 2, description: "SAD", emoji: ""),

TodoItem(id: 3, description: "COLD", emoji: "")
]

