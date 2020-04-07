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
    
    let service = FileService<Anotation>()
    let utils = Utils()
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
        utils.system("clear")
        show()
        while let input = readLine() {

            guard input != "0" else {
                break
            }

            switch input {
            case "1":
                options = .screenMyDiary
                utils.system("clear")
                run()
            case "2":   
                options = .screenGrade
                utils.system("clear")
                run()
            case "3":
                options = .screenPerfil
                utils.system("clear")
                run()
            default:
                print("?")
            }
            utils.system("clear")
            show()
        }
    }
}
