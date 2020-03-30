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
    case search
    case addAnotation
    case editAnotation
    case deleteAnotation
}

public class ScreenMyDiary {
    
    weak var delegate: DiaryOptionsDelegate?
    var options = DiaryOptionsEnum.search
    
    func run() {
        switch options {
        case .search:
            startSearchScreenDiary()
        case .addAnotation:
            delegate?.addAnotation()
        case .editAnotation:
            editAnotation()
        case .deleteAnotation:
            deleteAnotation()
        case .showAnotations:
            delegate?.showAnotations()
            delegate?.selectAnotationById()
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
                clearScreen()
                run()
            case "2":
                options = .search
                clearScreen()
                run()
            case "3":
                options = .addAnotation
                clearScreen()
                run()
            case "4":
                options = .editAnotation
                clearScreen()
                run()
            case "5":
                options = .deleteAnotation
                clearScreen()
                run()
            default:
                print("?")
        }
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
    
    private func deleteAnotation() {
        delegate?.showAnotations()
        print("digite um indice ou nome para deletar")
        guard let input = readLine() else {
            return
        }
        // if its number
        if let index = Int(input) {
            delegate?.deleteAnotation(title: nil, index: index)
        } else {
            delegate?.deleteAnotation(title: input, index: nil)
        }
    }
    
    private func editAnotation() {
        delegate?.showAnotations()
        print("digite um indice ou nome para alterar")
        guard let input = readLine() else {
            return
        }

        if let index = Int(input) {
            delegate?.editAnotation(title: nil, index: index)
        } else {
            delegate?.editAnotation(title: input, index: nil)
        }
    }
}
