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
            edit()
        case .deleteAnotation:
            deleteAnotation()
        case .showAnotations:
            delegate?.showAnotations()
            guard let anotation = delegate?.selectAnotationById() else{
                return
            }
            delegate?.showFormattedAnotation(anotation: anotation)
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
    
    func showSubmenuEdit() {
        print("""

        EDITAR:

        1 - título
        2 - texto
        3 - nome da disciplina
        4 - categoria

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
    
    
    private func edit() {
        delegate?.showAnotations()
        guard let anotation = delegate?.selectAnotationById()else{
            return
        }
        showSubmenuEdit()
        
        guard let input = readLine() else{ return
        }
        print("Digite o novo valor:")
        guard let newValue = readLine() else{
            return
        }
        switch input {
        case "1":
            delegate?.editAnotation(anotation: anotation, edit: .title, newValue: newValue)
        case "2":
            delegate?.editAnotation(anotation: anotation, edit: .note, newValue: newValue)
        case "3":
            delegate?.editAnotation(anotation: anotation, edit: .grade, newValue: newValue)
        case "4":
            delegate?.editAnotation(anotation: anotation, edit: .grade, newValue: newValue)
        default:
            print("opcao invalida")
        }
    }
}


