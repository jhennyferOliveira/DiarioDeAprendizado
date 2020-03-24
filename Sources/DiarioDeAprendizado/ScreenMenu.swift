//
//  Menu.swift
//  DiarioDeAprendizado
//
//  Created by Vinicius Mesquita on 15/03/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import Foundation

enum MenuOptionsEnum {
    case screenMyDiary
    case screenGrade
    case screenPerfil
}

public class ScreenMenu {
    
    weak var delegate: MenuOptionsDelegate?
    var options = MenuOptionsEnum.screenMyDiary
    
    func run() {
        switch options {
        case .screenMyDiary:
            delegate?.startScreenDiary()
        case .screenGrade:
            print("")
            // delegate?.showUserInformation()
        case .screenPerfil:
            print("")
            // delegate?.showGrades()
        }
    }
    
    func show() {
        print("""
        1 - meu diario
        2 - disciplinas
        3 - perfil
        """)
    }
    
    func main() {
        show()
        while let input = readLine() {

            guard input != "quit" else {
                break
            }

            switch input {
            case "1":
                options = .screenMyDiary
                run()
            case "2":
                options = .screenGrade
                run()
            case "3":
                options = .screenPerfil
                run()
            default:
                clearScreen()
                print("?")
                break
            }
            clearScreen()
            show()
        }
    }
    
    private func clearScreen() {
        let clear = Process()
        clear.launchPath = "/usr/bin/clear"
        clear.arguments = []
        clear.launch()
        clear.waitUntilExit()
    }
    
}
