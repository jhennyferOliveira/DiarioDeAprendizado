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
    let service = Service<Anotation>()
    weak var delegate: DiaryOptionsDelegate?
    var options = DiaryOptionsEnum.search
    
    func run() {
        switch options {
        case .search:
            startSearchScreenDiary()
        case .addAnotation:
            delegate?.addAnotation()
        case .editAnotation:
            startEditScreenDiary()
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

    func main() {
        show()
        while let input = readLine() {
            
            guard input != "0" else {
                break
            }
            switch input {
            case "1":
                options = .showAnotations
                service.clearScreen()
                run()
            case "2":
                options = .search
                service.clearScreen()
                run()
            case "3":
                options = .addAnotation
                service.clearScreen()
                run()
            case "4":
                options = .editAnotation
                service.clearScreen()
                run()
            case "5":
                options = .deleteAnotation
                service.clearScreen()
                run()
            default:
                print("?")
            }
            show()
        }
    }

    private func startSearchScreenDiary() {
        let screen = ScreenSearchNote()
        let options = DiaryOptions()
        screen.delegate = options
        screen.main()
    }
    
    private func startEditScreenDiary() {
        let screen = ScreenEditNote()
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
    
}


