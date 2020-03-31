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
    
    let service = Service<Anotation>()
    weak var delegate: MenuOptionsDelegate?
    var options = MenuOptionsEnum.screenMyDiary
    
    func run() {
        switch options {
        case .screenMyDiary:
            delegate?.startScreenDiary()
        case .screenGrade:
            delegate?.startScreenGrade()
        case .screenPerfil:
            delegate?.startScreenUser()
        }
    }
    
    func show() {
        print("""
        
        MENU PRINCIPAL:

        1 - Meu diario
        2 - Disciplinas
        3 - Perfil

        0 - Fechar

        """)
    }
    
    func main() {
        service.clearScreen()
        show()
        while let input = readLine() {

            guard input != "0" else {
                break
            }

            switch input {
            case "1":
                options = .screenMyDiary
                service.clearScreen()
                run()
            case "2":   
                options = .screenGrade
                service.clearScreen()
                run()
            case "3":
                options = .screenPerfil
                service.clearScreen()
                run()
            default:
                print("?")
            }
            service.clearScreen()
            show()
        }
    }
}
