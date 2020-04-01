//
//  File.swift
//  
//
//  Created by Vinicius Mesquita on 31/03/20.
//

import Foundation

public final class Utils {
    
    var currentUser = User()
    
    func system(_ arg: String) {
        switch arg {
        case "clear":
            clearTerminal()
        default:
            print("system error")
        }
    }
    
    func getCurrentUser() -> User {
        return currentUser
    }
    
    func setCurrentUser(user: User) {
        currentUser = user
    }
    
    private func clearTerminal() {
        let clear = Process()
        clear.launchPath = "/usr/bin/clear"
        clear.arguments = []
        clear.launch()
        clear.waitUntilExit()
    }
    
}
