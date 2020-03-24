//
//  Menu.swift
//  DiarioDeAprendizado
//
//  Created by Vinicius Mesquita on 15/03/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import Foundation

enum MenuOptionsEnum {
    case telaMeuDiario
    case telaDisciplina
    case telaPerfil
}

public class ScreenMenu {
    
    weak var delegate: MenuOptionsDelegate?
    var options = MenuOptionsEnum.telaMeuDiario
    
    func run() {
        switch options {
        case .telaMeuDiario:
            delegate?.showGrades()
        case .telaDisciplina:
            delegate?.showUserInformation()
        case .telaPerfil:
            delegate?.showGrades()
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
        while let input = readLine() {

            guard input != "quit" else {
                break
            }

            switch input {
            case "1":
                options = .telaMeuDiario
            case "2":
                options = .telaDisciplina
            case "3":
                options = .telaPerfil
            default:
                limparTela()
                print("?")
            }
            limparTela()
            run()
            show()
        }
    }
    
    private func limparTela() {
        let clear = Process()
        clear.launchPath = "/usr/bin/clear"
        clear.arguments = []
        clear.launch()
        clear.waitUntilExit()
    }
    
}
