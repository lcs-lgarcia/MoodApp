import Blackbird
import SwiftUI

@main
struct TodoItemsApp: App {
    var body: some Scene {
        WindowGroup {
            ListView()
                .environment(\.blackbirdDatabase, AppDatabase.instance)
        }
    }
}

