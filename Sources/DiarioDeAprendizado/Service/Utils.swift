//
//  File.swift
//  
//
//  Created by Vinicius Mesquita on 31/03/20.
//

import Foundation

public final class Utils {
    
    func system(_ arg: String) {
        switch arg {
        case "clear":
            clearTerminal()
        default:
            print("system error")
        }
    }
    
    private func clearTerminal() {
        let clear = Process()
        clear.launchPath = "/usr/bin/clear"
        clear.arguments = []
        clear.launch()
        clear.waitUntilExit()
    }
    
}
