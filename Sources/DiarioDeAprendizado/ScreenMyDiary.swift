//
//  ScreenSearchDiary.swift
//  testeCLI
//
//  Created by Vinicius Mesquita on 16/03/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import Foundation


enum DiaryOptionsEnum {
    case showAnotations
    case searchScreenDiary
    case addAnotation
    case editAnotation
    case deleteAnotation
}

public class ScreenMyDiary {
    
    weak var delegate: DiaryOptionsDelegate?
    var options = DiaryOptionsEnum.searchScreenDiary
    
    func run() {
        switch options {
        case .searchScreenDiary:
            startSearchScreenDiary()
        case .addAnotation:
            delegate?.addAnotation()
        case .editAnotation:
            delegate?.editAnotation()
        case .deleteAnotation:
            delegate?.deleteAnotation()
        case .showAnotations:
            delegate?.showAnotations()
        }
    }
    
    func show() {
        print("""

        MENU DIARIO:

        1 - mostrar todas as anotações
        2 - pesquisar por (nome, data, categoria)
        3 - adicionar anotação
        4 - editar anotação
        5 - apagar anotação

        0 - voltar
        """)
    }
    
    func main() {
        show()
        while let input = readLine() {
         
         guard input != "0" else {
             break
         }
        switch input {
            case "1":
                options = .showAnotations
                run()
            case "2":
                options = .searchScreenDiary
                run()
            case "3":
                options = .addAnotation
                run()
            case "4":
                options = .editAnotation
                run()
            case "5":
                options = .deleteAnotation
                run()
            default:
                print("?")
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
    // function to call submenu search diary
    private func startSearchScreenDiary() {
        let screen = SearchScreenDiary()
        let options = DiaryOptions()
        screen.delegate = options
        screen.main()
    }
}
